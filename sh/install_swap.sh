#!/bin/bash

# 默认大小（单位：MB）
DEFAULT_SIZE=1024

# 读取用户输入
read -p "请输入Swap文件大小（单位MB，默认1024）: " SIZE
SIZE=${SIZE:-$DEFAULT_SIZE}

SWAPFILE="/opt/swapfile"

# 创建Swap文件
echo "正在创建 $SIZE MB 的Swap文件..."
dd if=/dev/zero of=$SWAPFILE bs=1M count=$SIZE status=progress

# 设置交换文件权限
chmod 600 $SWAPFILE

# 设置为swap格式
mkswap $SWAPFILE

# 启用swap
swapon $SWAPFILE

# 添加到fstab以开机自动挂载（如果不存在则添加）
if ! grep -q "$SWAPFILE swap swap" /etc/fstab; then
    echo "$SWAPFILE swap swap defaults 0 0" >> /etc/fstab
    echo "已添加到 /etc/fstab"
fi

# 显示当前swap信息
echo "${GREEN}当前Swap使用情况："
swapon --show

echo "${GREEN}Swap配置完成（大小：$SIZE MB）"