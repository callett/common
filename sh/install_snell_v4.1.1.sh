#!/bin/bash

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

# 显示服务状态
systemctl status snell