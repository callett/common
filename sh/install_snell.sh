#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
NC='\033[0m' # 没颜色

set -e

# 更新系统并安装必要工具
apt update
apt install -y wget unzip vim

# 下载并安装 Snell Server
wget https://dl.nssurge.com/snell/snell-server-v4.1.1-linux-amd64.zip
unzip snell-server-v4.1.1-linux-amd64.zip -d /usr/local/bin
rm -f snell-server-v4.1.1-linux-amd64.zip
chmod +x /usr/local/bin/snell-server

# 创建配置目录
mkdir -p /etc/snell

# 启动 Snell Server 配置向导（用户需手动输入 Y 并配置）
/usr/local/bin/snell-server --wizard -c /etc/snell/snell-server.conf

# 创建 systemd 服务文件
cat > /lib/systemd/system/snell.service << EOF
[Unit]
Description=Snell Proxy Service
After=network.target

[Service]
Type=simple
User=nobody
Group=nogroup
LimitNOFILE=32768
ExecStart=/usr/local/bin/snell-server -c /etc/snell/snell-server.conf
AmbientCapabilities=CAP_NET_BIND_SERVICE
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=snell-server

[Install]
WantedBy=multi-user.target
EOF

# 启动并启用服务
systemctl daemon-reload
systemctl restart snell
systemctl enable snell

# 获取服务器公网IP
IP=$(curl -s https://api.ipify.org)

# 配置文件路径
CONFIG_FILE="/etc/snell/snell-server.conf"

# 提取 listen 和 psk 的值
PORT=$(grep '^listen' "$CONFIG_FILE" | awk -F ':' '{print $2}')
PSK=$(grep '^psk' "$CONFIG_FILE" | awk -F '=' '{print $2}' | tr -d ' ')

# 输出配置信息
echo
echo "${GREEN}Snell 配置信息："
echo "${GREEN}监听地址：0.0.0.0:${PORT}"
echo "${GREEN}PSK：${PSK}"
echo
echo "${GREEN}Surge 配置："
echo "${GREEN}snell, ${IP}, ${PORT}, psk=${PSK}, version=4, tfo=true"