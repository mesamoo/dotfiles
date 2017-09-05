#!/bin/bash
#
yad --title="Start kdeconnect?" --text="    Would you like to enable kdeconnect?  \n \n \n" --button=Yes:1 --button=No:2
#
if [ $? = 1 ]; then
#indicator-kdeconnect &
indicator-kdeconnect
else
	echo " have fun" >/dev/null
fi
