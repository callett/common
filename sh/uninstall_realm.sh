#!/bin/bash

echo "正在停止并卸载 Realm..."

# 停止并禁用 systemd 服务
systemctl stop realm.service
systemctl disable realm.service

# 删除 systemd 服务文件
rm -f /etc/systemd/system/realm.service

# 删除 Realm 可执行文件
rm -f /usr/local/bin/realm

# 删除 Realm 配置目录
rm -rf /etc/realm

# 重新加载 systemd
systemctl daemon-reload

echo "Realm 已成功卸载并删除所有相关配文件"