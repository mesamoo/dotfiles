#export QT_STYLE_OVERRIDE=gtk
## gtk seems to work best in pekwm and w / yast
#
##export QT_QPA_PLATFORMTHEME=lxqt
# With this plugin, all Qt-based programs can adopt settings of LXQt, such as the icon theme#
#   Next line uncommented after shitting in kde5 2016-08, commented again, trying to improve speed
#   uncommenting again, seems to fix yast, hopefully with  XDG_CURRENT_DESKTOP=KDE this will be useful
#   without next line qt fonts are fucking small and icons disappear qt apps don't respect kde settings
export QT_QPA_PLATFORMTHEME=qt5ct
#  haven't tried next line yet 2016-09-02
#  https://forum.xfce.org/viewtopic.php?id=9668
#  next line may help with speed of kde apps opening but
#  many sites warn against using this variable on non-kde environments
#XDG_CURRENT_DESKTOP=KDE  
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
