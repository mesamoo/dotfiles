#!/bin/bash
# before install, do
# ln -sf /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target
# 
#
#It is probably a good idea to update rtl driver before reboot if possible
#following will fail after reboot to new kernel, 
#do by hand before reboot
###
###d=$(date +%y-%m-%d)
###    cd /usr/local/src
###    mv /usr/local/src/rtl8192cu-fixes /usr/local/src/rtl8192cu-fixes_$d
###    git clone https://github.com/pvaret/rtl8192cu-fixes.git
#
#
# then reboot w/ nomodeset option
# script to install nvidia
# install virtualbox modules
# rebuild stupid realtek driver
# set machine back to graphical boot
#
echo ""
#lterm support is /nv/361.45.11
#beta is,2016-08-15 is 370.23beta
#current is, 367.44
#current is, 370.28
echo "I will now install the nvidia 370.28 driver (kernel 4.7 compatible)"
echo "     Press enter to continue... Press ctrl+c to cancel"
read -n 1 -s
#/nv/370.23beta
#/nv/361.45.11
#/nv/367.44
/nv/370.28
sleep 1
echo ""
echo "Now I will install vbox host drivers"
echo "     Press enter to continue... Press ctrl+c to cancel"
echo "     nb. With vBox 5.1 this may no longer be strictly necessary"
read -n 1 -s
/sbin/rcvboxdrv setup
sleep 1
echo ""
echo "Now I will build and install the rtl8192cu wifi driver"
echo "     Press enter to continue... Press ctrl+c to cancel."
read -n 1 -s
cd /usr/local/src/
sleep 1
cd /usr/local/src/rtl8192cu-fixes/
pwd
make clean
sleep 1
make
make install
depmod -a
sleep 1
echo ""
echo "I will now: "
echo "     set init back to graphical environment"
echo "     run sync and sed and sync"
echo ""
echo "     Press ctrl+c to cancel, just press enter to continue"
read -n 1 -s
ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
sleep 1
sync
sed -i 's:macroEnabled:macroenabled:g' /usr/share/mime/subclasses
sync
echo " you may now reboot"
