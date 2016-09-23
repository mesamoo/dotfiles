#!/bin/bash
# before install, do
# ln -sf /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target
# 
echo ""
#lterm support is /nv/361.45.11
#current is,2016-07-15 is 367.35
#echo "Shall I install the nvidia 361.45.11 driver"
#echo "Shall I install the nvidia 370.23beta driver"
echo "Shall I install the nvidia 367.44 driver"
echo "Press ctrl+c to cancel, just press enter to continue"
read -n 1 -s
/nv/367.44
sleep 1
echo ""
echo "Now I will install vbox host drivers"
echo "Press ctrl+c to cancel, just press enter to continue"
echo "With vBox 5.1 this may no longer be strictly necessary"
read -n 1 -s
/sbin/rcvboxdrv setup
sleep 1
echo ""
echo "Now I will set init back to graphical environment"
echo "And run sync and sed"
echo "Press ctrl+c to cancel, just press enter to continue"
read -n 1 -s
ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
sleep 1
sync
sed -i 's:macroEnabled:macroenabled:g' /usr/share/mime/subclasses
sync
echo " you may now reboot"
