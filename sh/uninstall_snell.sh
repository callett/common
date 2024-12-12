#!/bin/bash

# 提升权限
if [ "$EUID" -ne 0 ]; then
  echo "请以 root 用户运行此脚本！"
  exit 1
fi

echo "停止 Snell 服务..."
systemctl stop snell 2>/dev/null

echo "禁用 Snell 服务..."
systemctl disable snell 2>/dev/null

echo "删除 Systemd 服务文件..."
rm -f /lib/systemd/system/snell.service

echo "删除 Snell 二进制文件..."
rm -f /usr/local/bin/snell-server

echo "删除 Snell 配置文件和目录..."
rm -rf /etc/snell

echo "重新加载 Systemd 配置..."
systemctl daemon-reload

echo "清理完成！Snell Server 已成功卸载。"