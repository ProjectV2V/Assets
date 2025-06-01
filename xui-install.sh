#!/bin/bash
sleep 15
export DEBIAN_FRONTEND=noninteractive

# تنظیم iptables-persistent بدون سؤال
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections

# دانلود و نصب نسخه خاص از 3x-ui
cd /root
wget https://raw.githubusercontent.com/mhsanaei/3x-ui/v2.5.2/install.sh -O install-3x.sh
chmod +x install-3x.sh
yes n | bash install-3x.sh v2.5.2

# تعویض دیتابیس
sleep 10
systemctl stop x-ui
wget -O /etc/x-ui/x-ui.db https://raw.githubusercontent.com/ProjectV2V/Assets/main/x-ui.db
chown root:root /etc/x-ui/x-ui.db
chmod 600 /etc/x-ui/x-ui.db

# دریافت سرتیفیکیت‌ها
wget -O /root/cert.crt https://raw.githubusercontent.com/ProjectV2V/Assets/main/cert.crt
wget -O /root/private.key https://raw.githubusercontent.com/ProjectV2V/Assets/main/private.key
chmod 600 /root/*.key

# ریستارت نهایی
systemctl restart x-ui
echo '✅ x-ui auto install done!' > /root/script_status.txt
