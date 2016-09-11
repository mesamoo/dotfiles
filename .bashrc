if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

xhost +local:root > /dev/null 2>&1
complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
#export EDITOR=kwrite
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'kwrite'; else echo 'mcedit'; fi)"
#export LADSPA_PATH=/usr/lib64/ladspa/

export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$PATH"

###Add the following line to your ~/.bashrc 
#export PYTHONDOCS=/usr/share/doc/python2/html/
## previous lines removed at suse13.1 install
export LADSPA_PATH=/usr/lib64/ladspa:/usr/lib/ladspa:/usr/local/lib/ladspa:~/.ladspa
## previous lines added back 2015-12


alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp='cp -i'                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'

#DH aliades
# deletes all but the current and previous 2 versions of 
# installed packages in the pacman cache:
# http://wiki.manjaro.org/index.php?title=Maintaining_/var/cache/pacman/pkg_for_System_Safety
# alias pcc="sudo pkgcacheclean 2"

# reinitialise the Terminal so as to be able
# to use any changes made to the ~/.bashrc :
# http://wiki.manjaro.org/index.php?title=Maintaining_/var/cache/pacman/pkg_for_System_Safety
alias sorc='source ~/.bashrc'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# original manjaro prompt
#PS1='[\u@\h \W]\$ '

#following code creates a command timer http://jakemccrary.com/blog/2015/05/03/put-the-last-commands-run-time-in-your-bash-prompt/
function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
  PROMPT_COMMAND="timer_stop"
else
  PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi
PS1='\033[0;36m\n\nprev cmd returned after: ${timer_show} seconds\n\[\033[1;37;44m\]\@ \[\033[1;32m\][\u@\h] \[\033[1;37;44m\]\w \033[0;36m\n---->\[\033[1;37m\] '
#PS1='[last: ${timer_show}s][\w]$ '

#start
# Check for an interactive session
#PS1='\[\033[1;33m\]\u\]\[\033[1;37m\]@\[\033[1;32m\]\h \[\e[1\n;'

#following added by https://github.com/trapd00r/LS_COLORS
##eval $(dircolors -b $HOME/.dircolors-zsh)
#following added for AUR version of https://github.com/trapd00r/LS_COLORS
#eval `dircolors -b /usr/share/LS_COLORS`

#next line also added to .profile
VAGRANT_DEFAULT_PROVIDER=virtualbox

BROWSER=/usr/bin/xdg-open
export VAGRANT_DEFAULT_PROVIDER=virtualbox
