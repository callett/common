#!/bin/bash

# 设置版本
GRAFANA_VERSION="11.3.1"
GRAFANA_PACKAGE="grafana-enterprise_${GRAFANA_VERSION}_amd64.deb"
DOWNLOAD_URL="https://dl.grafana.com/enterprise/release/${GRAFANA_PACKAGE}"

# 更新系统并安装依赖
echo "Updating system and installing dependencies..."
apt-get update -y && apt-get install -y adduser libfontconfig1 musl

# 下载 Grafana 安装包
echo "Downloading Grafana v${GRAFANA_VERSION}..."
wget -q ${DOWNLOAD_URL} -O ${GRAFANA_PACKAGE}
if [ $? -ne 0 ]; then
    echo "Failed to download Grafana. Please check your internet connection or the URL."
    exit 1
fi

# 安装 Grafana
echo "Installing Grafana..."
dpkg -i ${GRAFANA_PACKAGE}
if [ $? -ne 0 ]; then
    echo "Failed to install Grafana. Please check for errors."
    exit 1
fi

# 清理安装包
rm -f ${GRAFANA_PACKAGE}

# 重新加载 systemd 配置并启用 Grafana 服务
echo "Configuring Grafana service..."
systemctl daemon-reload
systemctl enable grafana-server.service
systemctl start grafana-server.service

# 检查服务状态
echo "Checking Grafana service status..."
systemctl status grafana-server.service --no-pager

echo "Grafana installation completed! Access it via http://<your-server-ip>:3000"