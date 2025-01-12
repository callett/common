#!/bin/bash

# 更新系统包列表
echo "Updating package list..."
apt update

# 安装 Nginx 编译依赖
echo "Installing required dependencies..."
apt install -y build-essential libpcre3 libpcre3-dev zlib1g-dev libssl-dev wget

# 下载并解压 Nginx 源码
echo "Downloading Nginx source code..."
wget http://nginx.org/download/nginx-1.27.3.tar.gz
echo "Extracting Nginx source..."
tar -xvzf nginx-1.27.3.tar.gz
cd nginx-1.27.3

# 配置 Nginx
echo "Configuring Nginx..."
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx \
            --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log \
            --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid \
            --with-http_ssl_module --with-http_v2_module --with-http_gzip_static_module \
            --with-http_stub_status_module --with-threads --with-stream --with-stream_ssl_module

# 编译和安装 Nginx
echo "Compiling and installing Nginx..."
make
make install

# 验证 Nginx 安装
echo "Verifying Nginx installation..."
nginx -v
which nginx

# 创建 systemd 服务文件
echo "Creating systemd service file for Nginx..."
cat > /lib/systemd/system/nginx.service <<EOL
[Unit]
Description=The nginx HTTP and reverse proxy server
After=network.target

[Service]
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/usr/sbin/nginx -s stop
PIDFile=/var/run/nginx.pid

[Install]
WantedBy=multi-user.target
EOL

# 启用并启动 Nginx 服务
echo "Enabling and starting Nginx service..."
systemctl enable nginx
systemctl start nginx
systemctl status nginx

echo "Nginx installation and configuration complete!"