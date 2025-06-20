#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
NC='\033[0m'

# 停止并卸载旧服务
echo -e "${GREEN}正在停止并卸载旧版 Shadowsocks-Rust 服务...${NC}"
sudo systemctl stop ssserver.service
sudo systemctl disable ssserver.service
sudo rm -f /etc/systemd/system/ssserver.service
sudo rm -rf /etc/shadowsocks-rust
sudo rm -f /usr/local/bin/ssserver

# 清理旧目录（可选）
rm -rf ~/ss

# 获取公网 IP
IP=$(curl -s https://api.ipify.org)

# 设置默认端口
DEFAULT_PORT=443
read -p "请输入端口号（默认: $DEFAULT_PORT）: " PORT
PORT=${PORT:-$DEFAULT_PORT}

# 随机生成密码
PASSWORD=$(head /dev/urandom | tr -dc 'A-Za-z0-9@%' | head -c 16)

# 下载并部署 Shadowsocks-Rust 最新版
mkdir -p ~/ss && cd ~/ss
wget -q https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.23.0/shadowsocks-v1.23.0.x86_64-unknown-linux-gnu.tar.xz
tar -xf shadowsocks-v1.23.0.x86_64-unknown-linux-gnu.tar.xz && rm -f shadowsocks-v1.23.0.x86_64-unknown-linux-gnu.tar.xz
sudo mv ssserver /usr/local/bin
sudo mkdir -p /etc/shadowsocks-rust

# 写入配置文件（使用 chacha20-ietf-poly1305）
sudo tee /etc/shadowsocks-rust/config.json > /dev/null << EOF
{
  "server": "0.0.0.0",
  "server_port": $PORT,
  "method": "chacha20-ietf-poly1305",
  "password": "$PASSWORD",
  "fast_open": true,
  "no_delay": true,
  "timeout": 300
}
EOF

# 创建 systemd 服务文件
sudo tee /etc/systemd/system/ssserver.service > /dev/null << EOF
[Unit]
Description=Shadowsocks Rust Server (chacha20)
After=network.target

[Service]
ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks-rust/config.json
Restart=on-failure
LimitNOFILE=51200

[Install]
WantedBy=multi-user.target
EOF

# 启动新服务
sudo systemctl daemon-reexec
sudo systemctl enable ssserver --now

# 输出配置信息
echo
echo -e "${GREEN}✅ Shadowsocks 配置完成！${NC}"
echo -e "${GREEN}服务器地址：${IP}${NC}"
echo -e "${GREEN}端口：${PORT}${NC}"
echo -e "${GREEN}密码：${PASSWORD}${NC}"
echo -e "${GREEN}加密方式：chacha20-ietf-poly1305${NC}"
echo
echo -e "${GREEN}🎯 Clash / Stash 配置：${NC}"
echo -e "${GREEN}- name: SS-chacha20${NC}"
echo -e "${GREEN}  type: ss${NC}"
echo -e "${GREEN}  server: ${IP}${NC}"
echo -e "${GREEN}  port: ${PORT}${NC}"
echo -e "${GREEN}  cipher: chacha20-ietf-poly1305${NC}"
echo -e "${GREEN}  password: ${PASSWORD}${NC}"
echo
echo -e "${GREEN}📱 Shadowrocket 格式：${NC}"
echo -e "${GREEN}ss://${(echo -n "chacha20-ietf-poly1305:$PASSWORD@$IP:$PORT" | base64)}#SS-chacha20${NC}"