#!/bin/bash

# 更新系统包索引
echo "Updating package list..."
apt update

# 添加 Redis 官方 GPG 密钥
echo "Adding Redis GPG key..."
curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

# 设置文件权限
echo "Setting permissions for Redis GPG key..."
chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg

# 添加 Redis 官方 APT 仓库
echo "Adding Redis APT repository..."
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list

# 更新包索引并安装 Redis
echo "Updating package list and installing Redis..."
apt update
apt install -y redis

# 启动并启用 Redis 服务
echo "Starting and enabling Redis service..."
systemctl start redis-server
systemctl enable redis-server

echo "Redis installation and configuration complete!"