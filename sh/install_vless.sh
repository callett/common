#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
NC='\033[0m' # 没颜色

IP=$(curl -s https://api.ipify.org)

# 提示用户输入端口
read -p "请输入监听端口（默认 443）: " PORT
PORT=${PORT:-443}

# 提示用户输入伪装域名
read -p "请输入伪装域名 ServerName（默认 www.microsoft.com）: " SERVER_NAME
SERVER_NAME=${SERVER_NAME:-www.microsoft.com}

# 安装 Xray
echo -e "${GREEN}正在安装 Xray...${NC}"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# 生成 UUID 和密钥对
UUID=$(xray uuid)
KEYS=$(xray x25519)
PRIVATE_KEY=$(echo "$KEYS" | grep 'Private key' | awk '{print $NF}')
PUBLIC_KEY=$(echo "$KEYS" | grep 'Public key' | awk '{print $NF}')

# 生成 16 位 shortId
SHORT_ID=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 16 | head -n 1)

# 写入 Xray 配置文件
CONFIG_PATH="/usr/local/etc/xray/config.json"
cat > "$CONFIG_PATH" << EOF
{
  "log": {
    "loglevel": "debug"
  },
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "reality",
        "realitySettings": {
          "dest": "$SERVER_NAME:443",
          "serverNames": [
            "$SERVER_NAME"
          ],
          "privateKey": "$PRIVATE_KEY",
          "shortIds": [
            "",
            "$SHORT_ID"
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls",
          "quic"
        ],
        "routeOnly": true
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    }
  ]
}
EOF

# 重启 Xray
systemctl restart xray
sleep 1
systemctl status xray --no-pager

echo "${GREEN}Vless 安装完成！"
echo "${GREEN}监听端口：$PORT"
echo "${GREEN}公钥信息：$PUBLIC_KEY"
echo "${GREEN}shortId：$SHORT_ID"
echo "${GREEN}UUID: $UUID"
echo "${GREEN}伪装域名: $SERVER_NAME"
echo
# 输出 Clash 配置参考
echo -e "\n${GREEN}Clash 配置参考：${NC}"
echo "${GREEN}- {name: vless, server: $IP, port: $PORT, reality-opts: {public-key: $PUBLIC_KEY, short-id: $SHORT_ID}, client-fingerprint: chrome, type: vless, uuid: $UUID, tls: true, udp: true, tfo: false, skip-cert-verify: true, flow: xtls-rprx-vision, servername: $SERVER_NAME, network: tcp}"