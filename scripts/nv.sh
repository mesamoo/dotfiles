#!/bin/bash
# before install, do
# SWITCH RUNLEVEL
#       ln -sf /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target
#
#                                       IGNORE NEXT SECTION (PATCH for VBOX) UNLESS BUILDING OWN KERNEL
#                                                                            PATCH for VBOX 5.0.28 and KERNEL 4.8
#                                                                                           cd /usr/src/linux-4.x.x
#                                                                                  or
#                                                                                           cd /usr/src/linux/
#                                                                                           patch -p1 < /nv/vbox5.0/vboxhost_5.0.28r111378_kernel_4.8.2.patch
#                                                                                  the location above is where I stored the patch
#
# UPDATE WI-FI DRIVER (RTL)
#   It is probably a good idea to update rtl driver sources before reboot if possible
#   following will fail after reboot to new kernel, 
#   do by hand before reboot
###
###    d=$(date +%y-%m-%d)
###    cd /usr/local/src
###    mv /usr/local/src/rtl8192cu-fixes /usr/local/src/rtl8192cu-fixes_$d
###    git clone https://github.com/pvaret/rtl8192cu-fixes.git
#
#
# REBOOT w/ NOMODESET OPTION
#   script to install nvidia
#   install virtualbox modules
#   rebuild stupid realtek driver
#   set machine back to graphical boot
#
echo ""

#colors
C1='\033[0;33m' # brown
C2='\033[1;32m' # green
C3='\033[1;33m' # yello
C4='\033[1;37m' # white
NC='\033[0m' # No Color
#end colors

# note, the following "${C2}" and other references provide colored output in the script
echo -e ${C2} ""
#echo "I will now install the nvidia 381.22 beta driver (2017-5-10) (kernel 4.11 compatible)"
#echo "I will now install the nvidia 375.82 beta driver (2017-7-24) (kernel 4.11 compatible)"
#echo "I will now install the nvidia 384.59 beta driver (2017-7-24) (kernel 4.11 compatible)"
echo "I will now install the nvidia 384.69 beta driver (2017-8-24) (kernel 4.11 compatible)"
echo "     Press enter to continue... Press ctrl+c to cancel"
read -n 1 -s
echo -e ${NC} ""
#/nv/381.22
#/nv/375.82
#/nv/384.59
/nv/384.69
sleep 1
echo ""

echo -e ${C2} ""
echo "Now I will install vbox host drivers"
echo "     Press enter to continue... Press ctrl+c to cancel"
echo "     nb. With vBox 5.1 this may no longer be strictly necessary"
read -n 1 -s
echo -e ${NC} ""
/sbin/rcvboxdrv setup	#for oracle version
#/sbin/vboxconfig	#for suse version, may require internet

sleep 1
echo -e ${C2} ""
echo "Now I will build and install the rtl8192cu wifi driver"
echo "     Press enter to continue... Press ctrl+c to cancel."
read -n 1 -s
echo -e ${NC} ""
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

echo -e ${C2} ""
echo "I will now: "
echo "     set init back to graphical environment"
echo "     run sync and sed and sync"
echo ""
echo "     Press ctrl+c to cancel, just press enter to continue"
read -n 1 -s
echo -e ${NC} ""
ln -sf /usr/lib/systemd/system/graphical.target /etc/systemd/system/default.target
sleep 1
sync
sed -i 's:macroEnabled:macroenabled:g' /usr/share/mime/subclasses
sync
sync
echo -e ${C3} ""
echo " you may now reboot"

