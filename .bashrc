# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"



LANG="fr_FR.UTF-8"
LANGUAGE="fr:en"



# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

function __setprompt {
  local BLUE="\[\033[0;34m\]"
  local NO_COLOUR="\[\033[0m\]"
  local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
  local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
  if [ $SSH2_IP ] || [ $SSH_IP ] ; then
      local SSH_FLAG="@\h"
  fi
      PS1="$BLUE[\$(date +%H:%M)][\u$SSH_FLAG:\W]\\$ $NO_COLOUR"
      PS2="$BLUE>$NO_COLOUR "
      PS4='$BLUE+$NO_COLOUR '
		      }
__setprompt
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'
alias op='xdg-open'
alias galaxy='sh ~/galaxy_server/galaxy-dist/run.sh --reload'
alias edit='geany'
alias open='evince'
alias bc='bc -l'
alias assort='cd /media/etienne/western3TB/data/assortmate_data/'
alias buc='cd /media/etienne/western3TB/data/BUC_data/'
alias isemclust='ssh -X eloire@162.38.181.17'
alias terminator='terminator -l test'
alias dirloop='for i in `ls -l | awk '\''/^d/{print $NF}'\''` ; do '
alias Treeview='java -jar ../TreeView-1.1.6r4-bin/TreeView.jar'
alias macse='java -jar ~/bin/macse_v0.9b1.jar'
alias scanner='gscan2pdf'
alias candidates='cd /media/etienne/western3TB/data/assortmate_data/RSEM/RefAssembly/Transcript_VMNR_alig/Mus_candidates'
alias mus='cd /home/etienne/projet/Mus_Microsat'
# grid engine library location

export DRMAA_LIBRARY_PATH=/usr/lib/libdrmaa.so
export SGE_ROOT=/var/lib/gridengine/
export SGE_CELL=SpeciationCell
# add local path to $PATH

export PATH=/usr/local:/home/etienne/bin:/home/etienne/bin/IGVTools:/home/etienne/src/rsem-1.2.5:/usr/share/samtools/:$PATH
# python path
export PYTHONPATH=$PYTHONPATH:/home/etienne/src/my_python_mod 



# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Lines added by the Vim-R-plugin command :RpluginConfig (2014-avril-23 11:19):
# Change the TERM environment variable (to get 256 colors) and make Vim
# connecting to X Server even if running in a terminal emulator (to get
# dynamic update of syntax highlight and Object Browser):
if [ "x$DISPLAY" != "x" ]
then
    export HAS_256_COLORS=yes
    alias tmux="tmux -2"
    if [ "$TERM" = "xterm" ]
    then
        export TERM=xterm-256color
    fi
    alias vim="vim --servername VIM"
    if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]
    then
        function tvim(){ tmux -2 new-session "TERM=screen-256color vim --servername VIM $@" ; }
    else
        function tvim(){ tmux new-session "vim --servername VIM $@" ; }
    fi
else
    if [ "$TERM" == "xterm" ] || [ "$TERM" == "xterm-256color" ]
    then
        export HAS_256_COLORS=yes
        alias tmux="tmux -2"
        function tvim(){ tmux -2 new-session "TERM=screen-256color vim $@" ; }
    else
        function tvim(){ tmux new-session "vim $@" ; }
    fi
fi
if [ "$TERM" = "screen" ] && [ "$HAS_256_COLORS" = "yes" ]
then
    export TERM=screen-256color
fi
