#!/bin/bash

# 设置 Prometheus 版本
PROMETHEUS_VERSION="2.53.3"
INSTALL_DIR="/usr/local"
SERVICE_FILE="/etc/systemd/system/prometheus.service"

# 下载 Prometheus 压缩包
echo "Downloading Prometheus v${PROMETHEUS_VERSION}..."
wget -q https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz -O prometheus.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download Prometheus. Please check your internet connection."
    exit 1
fi

# 解压并移动文件
echo "Installing Prometheus..."
tar -zxvf prometheus.tar.gz -C ${INSTALL_DIR} >/dev/null
mv ${INSTALL_DIR}/prometheus-${PROMETHEUS_VERSION}.linux-amd64 ${INSTALL_DIR}/prometheus
rm -f prometheus.tar.gz

# 移动二进制文件
echo "Moving binaries..."
mv ${INSTALL_DIR}/prometheus/prometheus /usr/local/bin/
mv ${INSTALL_DIR}/prometheus/promtool /usr/local/bin/

# 移动配置文件
echo "Moving configuration files..."
mkdir -p /etc/prometheus
mv ${INSTALL_DIR}/prometheus/prometheus.yml /etc/prometheus/
mv ${INSTALL_DIR}/prometheus/consoles /etc/prometheus/
mv ${INSTALL_DIR}/prometheus/console_libraries /etc/prometheus/

# 创建 Prometheus 用户
echo "Creating Prometheus user..."
useradd --no-create-home --shell /bin/false prometheus

# 创建所需目录并设置权限
echo "Setting permissions..."
mkdir -p /var/lib/prometheus
mkdir -p /var/log/prometheus
chown -R prometheus:prometheus /usr/local/bin/prometheus
chown -R prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus
chown prometheus:prometheus /var/log/prometheus

# 创建 systemd 服务文件
echo "Creating systemd service..."
cat > ${SERVICE_FILE} << EOF
[Unit]
Description=Prometheus Monitoring System
Documentation=https://prometheus.io/docs/introduction/overview/
After=network.target

[Service]
User=prometheus
Group=prometheus
WorkingDirectory=/var/lib/prometheus
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus
Restart=always
RestartSec=5s
LimitNOFILE=65536
StandardOutput=append:/var/log/prometheus/prometheus.log
StandardError=append:/var/log/prometheus/prometheus_error.log

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd 并启动服务
echo "Reloading systemd and starting Prometheus service..."
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus

# 检查服务状态
echo "Checking Prometheus service status..."
systemctl status prometheus --no-pager

echo "Prometheus installation and configuration completed!"