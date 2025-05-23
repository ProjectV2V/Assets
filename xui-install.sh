#!/bin/bash
sleep 15
export DEBIAN_FRONTEND=noninteractive
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
yes n | bash <(curl -s https://raw.githubusercontent.com/Adymob123/V2RaySetup/refs/heads/main/setup-v2ray.sh)
sleep 10
systemctl stop x-ui
wget -O /etc/x-ui/x-ui.db https://raw.githubusercontent.com/ProjectV2V/Assets/main/x-ui.db
chown root:root /etc/x-ui/x-ui.db
chmod 600 /etc/x-ui/x-ui.db
wget -O /root/cert.crt https://raw.githubusercontent.com/ProjectV2V/Assets/main/cert.crt
wget -O /root/private.key https://raw.githubusercontent.com/ProjectV2V/Assets/main/private.key
chmod 600 /root/*.key
systemctl restart x-ui
echo '✅ x-ui auto install done!' > /root/script_status.txt
