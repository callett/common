#!/bin/bash

IP=$(curl -s https://api.ipify.org)

set -e

# 更新系统并安装基础依赖
echo "正在安装依赖..."
sudo apt update
sudo apt install -y curl gnupg2 ca-certificates lsb-release

# 导入 Nginx 签名密钥
echo "导入 Nginx 签名密钥..."
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg > /dev/null

# 添加官方 Nginx 仓库
DISTRO_CODENAME=$(lsb_release -cs)
echo "添加 Nginx 官方仓库 (${DISTRO_CODENAME})..."
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian ${DISTRO_CODENAME} nginx" | sudo tee /etc/apt/sources.list.d/nginx.list

# 更新并安装 Nginx
echo "更新源并安装 Nginx..."
sudo apt update
sudo apt install -y nginx

# 启动并设置开机自启
echo "启动 Nginx 并设置开机启动..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Nginx 安装完成。访问 http://${IP} 测试是否安装成功。"