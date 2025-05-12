#!/bin/bash

# 提示用户输入 Socks5 信息
read -p "请输入落地服务器 IP: " REMOTE_IP
read -p "请输入落地服务器端口（默认 1080）: " REMOTE_PORT
REMOTE_PORT=${REMOTE_PORT:-1080}

read -p "是否需要指定落地协议？(Y/n，默认否): " NEED_TRANSPORT
NEED_TRANSPORT=${NEED_TRANSPORT:-n}

if [[ "$NEED_TRANSPORT" =~ ^[Yy]$ ]]; then
  read -p "请输入落地协议类型（如 socks5/tls/ws/http）: " TRANSPORT
else
  TRANSPORT=""
fi

if [[ "$TRANSPORT" == "socks5" || "$TRANSPORT" == "http" ]]; then
  read -p "落地服务器是否需要认证？(Y/n，默认否): " NEED_AUTH
  NEED_AUTH=${NEED_AUTH:-n}

  if [[ "$NEED_AUTH" =~ ^[Yy]$ ]]; then
    read -p "请输入认证用户名: " USERNAME
    read -s -p "请输入认证密码: " PASSWORD
    echo
  fi
else
  USERNAME=""
  PASSWORD=""
fi

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
remote = "${REMOTE_IP}:${REMOTE_PORT}"
EOF

# 如果用户填写了协议类型，则写入 transport 字段
if [ -n "$TRANSPORT" ]; then
echo "transport = \"${TRANSPORT}\"" >> /etc/realm/config.toml
fi

# 如果提供了用户名和密码，追加认证信息
if [ -n "$USERNAME" ]; then
cat <<EOF >> /etc/realm/config.toml
username = "${USERNAME}"
password = "${PASSWORD}"
EOF
fi

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

echo -e "\nRealm 已完成安装配置并启动"
echo "监听端口: 127.0.0.1:${REALM_PORT}"