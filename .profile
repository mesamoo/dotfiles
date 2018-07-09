#export QT_STYLE_OVERRIDE=gtk
## gtk seems to work best in pekwm and w / yast
#
##export QT_QPA_PLATFORMTHEME=lxqt
# With this plugin, all Qt-based programs can adopt settings of LXQt, such as the icon theme#
#removed for qedit test, no improvement, re added so kde5 apps use my theme
#export QT_QPA_PLATFORMTHEME=qt5ct
#
# try this, nope, fails too
#export QT_QPA_PLATFORMTHEME=lxqt
#
#[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
#back to useless
export QT_QPA_PLATFORMTHEME="qt5ct"
mount | grep "/home/0_gdrive" >/dev/null || /usr/bin/google-drive-ocamlfuse "/home/0_gdrive"
