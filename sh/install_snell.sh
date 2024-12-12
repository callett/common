#!/bin/bash

# 提升权限
if [ "$EUID" -ne 0 ]; then
  echo "请以 root 用户运行此脚本！"
  exit 1
fi

# 安装必要的软件包
echo "安装必要的软件包..."
apt update && apt install -y wget unzip vim

# 下载 Snell Server
SNELL_VERSION="4.1.1"
SNELL_FILE="snell-server-v${SNELL_VERSION}-linux-amd64.zip"
DOWNLOAD_URL="https://dl.nssurge.com/snell/${SNELL_FILE}"

echo "下载 Snell Server v${SNELL_VERSION}..."
wget -q ${DOWNLOAD_URL} -O ${SNELL_FILE}
if [ $? -ne 0 ]; then
  echo "下载 Snell Server 失败，请检查网络连接！"
  exit 1
fi

# 解压并移动到指定目录
echo "解压 Snell Server..."
unzip -o ${SNELL_FILE} -d /usr/local/bin
rm -f ${SNELL_FILE}
chmod +x /usr/local/bin/snell-server

# 创建配置目录
echo "创建配置目录..."
mkdir -p /etc/snell

# 生成随机端口和 PSK
PORT=$((RANDOM % 10000 + 10000)) # 生成 10000-19999 之间的随机端口
PSK=$(openssl rand -base64 16)

# 创建配置文件
echo "生成配置文件..."
cat > /etc/snell/snell-server.conf << EOF
[snell-server]
listen = 0.0.0.0:${PORT}
psk = ${PSK}
ipv6 = true
EOF

# 创建 Systemd 服务文件
echo "配置 Systemd 服务..."
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

# 重新加载 systemd 服务并启动 Snell
echo "启动 Snell 服务..."
systemctl daemon-reload
systemctl enable snell
systemctl restart snell

# 获取服务器的 IP 地址
SERVER_IP=$(hostname -I | awk '{print $1}')

# 打印配置信息
echo "Snell Server 安装和配置完成！"
echo "----------------------------------------"
echo "Snell 配置信息："
echo "监听地址：0.0.0.0:${PORT}"
echo "PSK 密钥：${PSK}"
echo "Surge 配置："
echo "snell = snell, ${SERVER_IP}, ${PORT}, psk=${PSK}, version=4, tfo=true"
echo "----------------------------------------"