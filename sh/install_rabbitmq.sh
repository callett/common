#!/bin/bash

IP=$(curl -s https://api.ipify.org)

set -e

echo "🟡 正在更新系统软件包..."
sudo apt update && sudo apt upgrade -y

echo "🟡 安装 Erlang 依赖..."
sudo apt install -y erlang curl gnupg apt-transport-https

echo "🟡 添加 RabbitMQ GPG 密钥和软件源..."
curl -fsSL https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey | sudo tee /etc/apt/trusted.gpg.d/rabbitmq.asc > /dev/null
echo "deb https://dl.bintray.com/rabbitmq/debian stable main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list

echo "🟡 更新包列表并安装 RabbitMQ..."
sudo apt update
sudo apt install -y rabbitmq-server

echo "🟢 启动 RabbitMQ 服务并设置开机自启..."
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server

echo "🟢 启用 RabbitMQ Web 管理插件..."
sudo rabbitmq-plugins enable rabbitmq_management

echo "🟡 配置 RabbitMQ 监听所有 IP 地址..."
sudo bash -c 'echo "listeners.tcp.default = 0.0.0.0:5672" > /etc/rabbitmq/rabbitmq.conf'

echo "🔁 重启 RabbitMQ 服务以应用配置..."
sudo systemctl restart rabbitmq-server

echo "✅ 安装与配置完成！"
echo "🌐 管理界面地址：http://${IP}:15672"
echo "🔐 默认账号密码：guest / guest"