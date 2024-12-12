#!/bin/bash

# 设置版本号
NODE_EXPORTER_VERSION="1.8.2"
INSTALL_DIR="/usr/local"
SERVICE_FILE="/etc/systemd/system/node_exporter.service"

# 下载 node_exporter 压缩包
echo "Downloading node_exporter v${NODE_EXPORTER_VERSION}..."
wget -q https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -O node_exporter.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download node_exporter. Please check your internet connection."
    exit 1
fi

# 解压并移动文件
echo "Installing node_exporter..."
tar -zxvf node_exporter.tar.gz -C ${INSTALL_DIR} >/dev/null
mv ${INSTALL_DIR}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64 ${INSTALL_DIR}/node_exporter
rm -f node_exporter.tar.gz

# 创建 node_exporter 用户
echo "Creating node_exporter user..."
useradd --no-create-home --shell /bin/false node_exporter

# 设置权限
echo "Setting permissions..."
chown -R node_exporter:node_exporter ${INSTALL_DIR}/node_exporter
mkdir -p /var/run/node_exporter
chown node_exporter:node_exporter /var/run/node_exporter

# 创建 systemd 服务文件
echo "Creating systemd service..."
cat > ${SERVICE_FILE} << EOF
[Unit]
Description=Node Exporter
Documentation=https://prometheus.io/docs/guides/node-exporter/
After=network.target

[Service]
User=node_exporter
Group=node_exporter
ExecStart=${INSTALL_DIR}/node_exporter/node_exporter
Restart=always
PIDFile=/var/run/node_exporter.pid

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd 并启动服务
echo "Reloading systemd and starting node_exporter service..."
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter

# 检查服务状态
echo "Checking node_exporter service status..."
systemctl status node_exporter --no-pager

echo "Node Exporter installation and configuration completed!"