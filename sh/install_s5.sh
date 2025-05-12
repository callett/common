#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
NC='\033[0m' # 没颜色

# 一些变量
USERNAME="socksuser"
# 随机生成32位密码
PASSWORD=$(head /dev/urandom | tr -dc 'A-Za-z0-9@%&' | head -c 32)
PORT="1080"
IFACE=$(ip route get 1 | awk '{print $5; exit}')
IP=$(curl -s https://api.ipify.org)

# 安装 dante-server
apt update && apt install -y dante-server

# 添加用户
useradd -M -s /usr/sbin/nologin $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

# 备份原配置
cp /etc/danted.conf /etc/danted.conf.bak

# 写入新的配置文件
cat > /etc/danted.conf <<EOF
logoutput: /var/log/danted.log
internal: 0.0.0.0 port = $PORT
external: $IFACE

method: username

user.notprivileged: nobody

client pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    log: connect disconnect error
}

socks pass {
    from: 0.0.0.0/0 to: 0.0.0.0/0
    command: connect
    log: connect disconnect error
}
EOF

# 设置开机启动并重启服务
systemctl enable danted
systemctl restart danted

# 防火墙放行（如有 ufw）
if command -v ufw >/dev/null 2>&1; then
    ufw allow ${PORT}/tcp
fi

echo "${GREEN}SOCKS5 安装完成！"
echo "${GREEN}监听端口：$PORT"
echo "${GREEN}用户名：$USERNAME"
echo "${GREEN}密码：$PASSWORD"
echo
echo "${GREEN}Surge 配置："
echo "${GREEN}socks5, ${IP}, ${PORT}, username=${USERNAME}, password=${PASSWORD}"