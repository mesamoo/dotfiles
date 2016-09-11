#!/bin/bash
#
yad --title="Start Baloo Search?" --text="    Would you like to enable KDE Desktop Search?  \n    If you choose yes, a window will open,   \n    in that window, press the Start button   \n \n" --button=Yes:1 --button=No:2
#
if [ $? = 1 ]; then
kcmshell4 kcm_baloofileadv
else
	echo " have fun" >/dev/null
fi
