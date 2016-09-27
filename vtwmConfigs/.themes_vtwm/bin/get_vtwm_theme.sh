#!/bin/sh
#
# replace a vtwm theme
#
#     Author:    John McCue
#     Copyright: public domain, no copyright
#

#------------------------------------------------------------------------------
# show themes and exit
#------------------------------------------------------------------------------
vtwm_usage()
{
    msg="$1"

    echo 'get_vtwm_theme.sh theme_name|KILL'

    echo 'Valid Themes:'
    ls $theme_dir | sed 's/^theme_//' | awk '{printf("%s\n",$NF)}' | sort -f | \
	    awk 'BEGIN{i=0}{printf("\t%-12s",$1); i++; if (i > 3) {i=0; printf("\n")}}END{printf("\n")}'


    if test "$msg" = ""
    then
	echo "ERROR: Aborted"
    else
	echo "ERROR - $msg"
    fi

    exit 1

}  # END: vtwm_usage()

#------------------------------------------------------------------------------
# kill applications
#------------------------------------------------------------------------------
killapp()
{
    killall asapm conky gkrellm oclock rclock              > /dev/null 2>&1
    killall wmWeather wmbiff                               > /dev/null 2>&1
    killall xapm xclock xeyes xload xlogo xnetload xplanet > /dev/null 2>&1
    killall xdaliclock emiclock oclock                     > /dev/null 2>&1
} # END killapp()

###############################################################################
# set defaults
###############################################################################

#-----------------------------------------------------------------------------
# find script dir
#-----------------------------------------------------------------------------
sdir=`dirname $0`
cwd=`pwd`
cd $sdir
sdir=`pwd`
cd $cwd

#-----------------------------------------------------------------------------
# source in defaults
#-----------------------------------------------------------------------------
. $sdir/theme_defaults.sh

###############################################################################
# main
###############################################################################

#------------------------------------------------------------------------------
# determine theme name
#------------------------------------------------------------------------------
arg_name="$1"

case "$arg_name" in
    "")
	vtwm_usage "E01: need theme name"
	;;
    "KILL")
	killapp
	exit 0
	;;
    *)
	if test -f "$theme_dir/$arg_name"
	then
	    theme_file="$theme_dir/$arg_name"
	    theme_name=`basename $theme_file | sed 's/^theme_//'`
	else
	    theme_name=`basename $arg_name | sed 's/^theme_//'`
	    theme_file="$theme_dir/theme_""$arg_name"
	    if test ! -f "$theme_file"
	    then
		vtwm_usage "E02: cannot find theme $arg_name"
	    fi
	fi
	;;
esac

#------------------------------------------------------------------------------
# $JMC_XRESOLUTION -- used to determine geometries
#------------------------------------------------------------------------------
if test "$JMC_XRESOLUTION" = ""
then
    RESFONT='##JMCRESOTHERS##'
else
    RESFONT='##JMCRES'"$JMC_XRESOLUTION"'##'
fi

#--- see which resolution to yes
grep "$RESFONT" "$theme_file" > /dev/null 2>&1
if test "$?" -ne "0"
then
    RESFONT='##JMCRESOTHERS##'
fi

#------------------------------------------------------------------------------
# replace themes
#------------------------------------------------------------------------------

if test -f "$rcfile"
then
    mv "$rcfile" "$rcfile~"
fi

sed "s/$RESFONT//g" "$theme_file" "$auto_raise" > "$rcfile"

#--- Add Icons
grep '^###ADD_ICONS###' "$rcfile" > /dev/null 2>&1
if test "$?" -eq "0"
then
    grep -v '^#' "$icon_file" >> "$rcfile"
fi

#--- add theme functions and menu
$theme_bin/mk_theme_menu.sh

#--- add menus
grep '^###ADD_MENU###' "$rcfile" > /dev/null 2>&1
if test "$?" -eq "0"
then
    sed "s/XXJMCTITLE/$theme_name/g" "$theme_menu"  >> "$rcfile"
fi

#------------------------------------------------------------------------------
# record theme
#------------------------------------------------------------------------------
echo "$theme_name" > $theme_inuse

#------------------------------------------------------------------------------
# kill theme related clients
#------------------------------------------------------------------------------
killapp

#------------------------------------------------------------------------------
# done
#------------------------------------------------------------------------------
exit 0

############################# END: get_vtwm_theme ##############################
