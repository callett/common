#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
NC='\033[0m'

USERNAME="socksuser"
PORT="1080"
CONFIG_FILE="/etc/danted.conf"
BACKUP_FILE="/etc/danted.conf.bak"
LOG_FILE="/var/log/danted.log"

echo -e "${GREEN}开始卸载 Dante SOCKS5 代理...${NC}"

# 停止并禁用服务
systemctl stop danted
systemctl disable danted

# 删除用户
if id "$USERNAME" &>/dev/null; then
    userdel "$USERNAME"
    echo -e "${GREEN}已删除用户 $USERNAME${NC}"
fi

# 恢复原始配置（如果有）
if [ -f "$BACKUP_FILE" ]; then
    mv "$BACKUP_FILE" "$CONFIG_FILE"
    echo -e "${GREEN}已恢复配置文件备份${NC}"
else
    echo -e "${GREEN}未找到备份配置文件，跳过恢复${NC}"
fi

# 删除日志文件
if [ -f "$LOG_FILE" ]; then
    rm -f "$LOG_FILE"
    echo -e "${GREEN}已删除日志文件${NC}"
fi

# 卸载 dante-server
apt remove --purge -y dante-server
apt autoremove -y
echo -e "${GREEN}已卸载 dante-server${NC}"

echo -e "${GREEN}Dante SOCKS5 已完全卸载。${NC}"