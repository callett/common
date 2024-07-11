搭建snell协议节点

Snell一键脚本
```
bash <(curl -fsSL https://raw.githubusercontent.com/chen-zeus/zeus/main/Surge/snell/snell.sh)
```

手动搭建
1.获取管理权限
```
sudo -i
```
2.安装vim, wget及unzip(如果没安装的话)
```
apt update && apt install wget && apt install unzip
```
3.下载 Snell Server
AMD:
```
wget https://raw.githubusercontent.com/chen-zeus/zeus/main/Surge/snell/snell-server-v4.0.1-linux-amd64.zip
```
ARM:
```
wget https://raw.githubusercontent.com/chen-zeus/zeus/main/Surge/snell/snell-server-v4.0.1-linux-aarch64.zip
```
4.解压 Snell Server 到指定目录
AMD:
```
unzip snell-server-v4.0.1-linux-amd64.zip -d /usr/local/bin
```
ARM:
```
unzip snell-server-v4.0.1-linux-aarch64.zip -d /usr/local/bin
```
5.赋予服务器权限
```
chmod +x /usr/local/bin/snell-server
```
6.编写配置文件
6.1先执行新建文件夹操作
```
mkdir /etc/snell
```
6.2
可以使用 Snell 的 wizard 生成一个配置文件
```
snell-server --wizard -c /etc/snell/snell-server.conf
```
或者自己编写一个
```
vim /etc/snell/snell-server.conf
```
编写配置文件内容
```
[snell-server]
listen = 0.0.0.0:11807
psk = AijHCeos15IvqDZTb1cJMX5GcgZzIVE
ipv6 = false
```
参数说明
listen：监听地址及端口； psk：密钥； ipv6：如果需要 IPv6 支持将值为 – true
7.配置 Systemd 服务文件
```
vim /lib/systemd/system/snell.service
```
服务文件内容
```
[Unit]
Description=Snell Proxy Service
After=network.target

[Service]
Type=simple
User=nobody
Group=nogroup
LimitNOFILE=32768
ExecStart=/usr/local/bin/snell-server -c /etc/snell/snell-server.conf
AmbientCapabilities=CAP_NET_BIND_SERVICE
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=snell-server

[Install]
WantedBy=multi-user.target
```
8.重载服务
```
systemctl daemon-reload
```
9.重启snell
```
systemctl restart snell
```


snell服务相关命令
开机运行 Snell
```
systemctl enable snell
```
开启 Snell
```
systemctl start snell
```
关闭 Snell
```
systemctl stop snell
```
查看 Snell 状态
```
systemctl status snell
```
查看Snell配置，q退出
```
cat /etc/snell/snell-server.conf
```


Surge相应配置
```
AWS-EC2-SG = snell, XXX.XXX.XXX.XXX, 11807, psk=AijHCeos15IvqDZTb1cJMX5GcgZzIVE, version=4, tfo=true
```
