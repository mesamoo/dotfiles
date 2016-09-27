#!/bin/sh
#
# Load themes menu and functions
#
#     Author:    John McCue
#     Copyright: public domain, no copyright
#

#------------------------------------------------------------------------------
# mk_menu()
#------------------------------------------------------------------------------
mk_menu()
{
    echo '#------------------------------------------------------------------------------'
    echo "# Created by $0"
    echo "#         on `date`"
    echo '#         menu  functions'
    echo '#------------------------------------------------------------------------------'
    echo 'menu "menu_vtwm_themes"'
    echo '{'
    echo '    "VTWM Themes"	f.title'
    lns="-1"
    for fname in `find $theme_dir -type f -print | sort -f`
    do
	lns=`expr $lns + 1`
	if test "$lns" -eq "3"
	then
	    echo '    ""		f.separator'
	    lns=0
	fi
	tname=`basename $fname | sed 's/theme_//'`
	echo "    \"$tname\"	f.function \"Theme_$tname\""
    done
    echo '}'

} # END: mk_menu()


#------------------------------------------------------------------------------
# mk_a_func
#------------------------------------------------------------------------------
mk_a_func()
{

    echo "Function \"Theme_$tname\""
    echo '{'
    echo "    f.exec \"$theme_bin/get_vtwm_theme.sh $tname\""
    echo "    f.restart"
    echo "}"

} # END: mk_a_func()

#------------------------------------------------------------------------------
# mk_func()
#------------------------------------------------------------------------------
mk_func()
{

    echo '#------------------------------------------------------------------------------' 
    echo "# Created by $0"                                                                 
    echo "#         on `date`"                                                             
    echo '#         theme functions'                                                       
    echo '#------------------------------------------------------------------------------' 

    for fname in `find $theme_dir -type f -print | sort -f`
    do
	tname=`basename $fname | sed 's/^theme_//'`
	mk_a_func "$fname"
    done

} # END: mk_func()

###############################################################################
# main
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

#------------------------------------------------------------------------------
# add functions and menu
#------------------------------------------------------------------------------
mk_func >> "$rcfile"
mk_menu >> "$rcfile"

exit 0
