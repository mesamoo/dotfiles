# Environment for VTWM theme files
#
# sourced into theme scripts
#
#     Author:    John McCue
#     Copyright: public domain, no copyright
#

#--- find location (probably for the 2nd time)
sdir=`dirname $0`
cwd=`pwd`
cd $sdir
cd ..
theme_home="`pwd`"

#--- set defaults
theme_bin="$theme_home/bin"
theme_data="$theme_home/data"
theme_dir="$theme_home/themes"
theme_inuse="$theme_data/theme.in.use"
theme_menu="$theme_data/menu.txt"
theme_func="$theme_data/theme_func.txt"
auto_raise="$theme_data/autoraise.txt"
icon_file="$theme_data/icons.txt"
rcfile=$HOME/.vtwmrc

