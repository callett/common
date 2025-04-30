#!/bin/bash
ip=$(curl -s https://api.ipify.org)
echo "公网 IP: $ip"