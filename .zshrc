# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistfile
HISTSIZE=1001
SAVEHIST=1001
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#following line changed from "zstyle :compinstall filename '/home/username/.zshrc'      
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#fix the java ugly font issue
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
