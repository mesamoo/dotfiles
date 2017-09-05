#!/bin/bash
# SWITCH RUNLEVEL
echo "switching to multiuser.target at boot"
ln -sf /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target
# UPDATE WI-FI DRIVER (RTL)
echo "update wi-fi driver source code"
d=$(date +%y-%m-%d-%H-%M)
cd /usr/local/src
mv /usr/local/src/rtl8192cu-fixes /usr/local/src/rtl8192cu-fixes_$d
git clone https://github.com/pvaret/rtl8192cu-fixes.git
