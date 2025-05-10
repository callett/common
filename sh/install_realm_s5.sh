#!/bin/bash

# 提示用户输入 Socks5 信息
read -p "请输入落地 Socks5 服务器 IP: " S5_REMOTE_IP
read -p "请输入落地 Socks5 端口（默认 1080）: " S5_REMOTE_PORT
S5_REMOTE_PORT=${S5_REMOTE_PORT:-1080}

read -p "请输入 Socks5 用户名: " S5_USERNAME
read -s -p "请输入 Socks5 密码: " S5_PASSWORD
echo

read -p "请输入 Realm 本地监听端口（默认 1081）: " REALM_PORT
REALM_PORT=${REALM_PORT:-1081}

# 安装依赖
apt update -y && apt install -y curl unzip

# 下载并安装 Realm
cd /tmp
curl -LO https://github.com/zhboner/realm/releases/latest/download/realm-x86_64-unknown-linux-gnu.tar.gz
tar -xzf realm-x86_64-unknown-linux-gnu.tar.gz
chmod +x realm
mv realm /usr/local/bin/

# 配置 Realm
mkdir -p /etc/realm
cat <<EOF > /etc/realm/config.toml
[log]
level = "info"

[[endpoints]]
listen = "127.0.0.1:${REALM_PORT}"
remote = "${S5_REMOTE_IP}:${S5_REMOTE_PORT}"
transport = "socks5"
username = "${S5_USERNAME}"
password = "${S5_PASSWORD}"
EOF

# systemd 服务
cat <<EOF > /etc/systemd/system/realm.service
[Unit]
Description=Realm TCP Forwarder
After=network.target

[Service]
ExecStart=/usr/local/bin/realm -c /etc/realm/config.toml
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# 启动服务
systemctl daemon-reload
systemctl enable --now realm.service

echo -e "\nRealm 已完成安装并启动"
echo "监听端口: 127.0.0.1:${REALM_PORT}"