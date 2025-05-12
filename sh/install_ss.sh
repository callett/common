#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
NC='\033[0m' # 没颜色

# 获取服务器公网IP
IP=$(curl -s https://api.ipify.org)

# 设置默认端口
DEFAULT_PORT=443
read -p "请输入端口号（默认: $DEFAULT_PORT）: " PORT
PORT=${PORT:-$DEFAULT_PORT}

# 随机生成32位密码
PASSWORD=$(head /dev/urandom | tr -dc 'A-Za-z0-9@%&' | head -c 32)

# 下载和部署 Shadowsocks-Rust
mkdir -p ~/ss && cd ~/ss
wget -q https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.23.0/shadowsocks-v1.23.0.x86_64-unknown-linux-gnu.tar.xz
tar -xf shadowsocks-v1.23.0.x86_64-unknown-linux-gnu.tar.xz && rm -f shadowsocks-v1.23.0.x86_64-unknown-linux-gnu.tar.xz
sudo mv ssserver /usr/local/bin
sudo mkdir -p /etc/shadowsocks-rust

# 创建配置文件
sudo tee /etc/shadowsocks-rust/config.json > /dev/null << EOF
{
  "server": "0.0.0.0",
  "server_port": $PORT,
  "password": "$PASSWORD",
  "method": "aes-256-gcm",
  "fast_open": true,
  "no_delay": true,
  "timeout": 300
}
EOF

# 创建 systemd 服务文件
sudo tee /etc/systemd/system/ssserver.service > /dev/null << EOF
[Unit]
Description=Shadowsocks Rust Server
After=network.target

[Service]
ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks-rust/config.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# 启动服务
sudo systemctl daemon-reexec
sudo systemctl enable ssserver --now

# 输出配置信息
echo
echo "${GREEN}Shadowsocks 配置信息："
echo "${GREEN}监听地址：0.0.0.0:${PORT}"
echo "${GREEN}密码：${PASSWORD}"
echo "${GREEN}加密方式：aes-256-gcm"
echo
echo "${GREEN}Surge 配置："
echo "${GREEN}ss, ${IP}, ${PORT}, encrypt-method=aes-256-gcm, password=${PASSWORD}, tfo=true"