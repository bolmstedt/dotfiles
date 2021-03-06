#!/usr/bin/env bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
export PATH="$PATH:vendor/bin:$HOME/bin:$HOME/.composer/vendor/bin"
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export TERM='xterm-256color'

# GIT PS settings
export GIT_PS1_SHOWDIRTYSTATE=1     # unstaged (*) and staged (+) changes
export GIT_PS1_SHOWSTASHSTATE=1     # stashed ($) changes
export GIT_PS1_SHOWUNTRACKEDFILES=1 # untracked (%) files
export GIT_PS1_SHOWUPSTREAM='auto'  # < behind, > ahead, <> diverged, = no diff

HOST_WARNING_COLOR='\e[48;5;196m'
HOST_COLOR='\e[38;5;232m'

PLATFORM='unknown'
UNAMESTR=`uname`
if [[ "$UNAMESTR" == 'Linux' ]]; then
   PLATFORM='linux'
elif [[ "$UNAMESTR" == 'FreeBSD' ]]; then
   PLATFORM='freebsd'
elif [[ "$UNAMESTR" == 'Darwin' ]]; then
   PLATFORM='mac'
fi

# Common aliases
if [[ ${PLATFORM} == 'linux' ]]; then
    alias ls='ls -AF --color=auto' # show hidden, indicator, color
else
    alias ls='ls -AFG' # show hidden, indicator, color
fi

alias nano="nano -lmw" # line numbers, cursor, no wrap
alias grep="grep -iI --color=always" # ignore case, ignore binary
alias less="less -iNR" # ignore case, line numbers, colorize output
alias ll="ls -lh" # long list, human readable
alias su="su -m" # keep current .bashrc
alias mv="mv -iv" # interactive, verbose
alias cp="cp -iv" # interactive, verbose
alias clr="echo;clear;ll" # Clear screen and list files
alias reload="exec $SHELL -l"   # Reload shell

# Alias for navigating
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cd..=".."
alias cd...="..."
alias cd....="...."
alias cd.....="....."
alias openfiles="lsof | awk '{ print $1; }' | uniq -c | sort -rn | head"

# Alias functions
alias reload="exec ${SHELL} -l"
alias localip='ipconfig getifaddr en0'

# macOS aliases
if [[ ${PLATFORM} == 'mac' ]] && [ -f ~/.macos ]; then
    source ~/.macos
fi

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

if [ -n "$(type -t __git_ps1)" ] && [ "$(type -t __git_ps1)" = function ]; then
    GITPS='\e[38;5;158m$(__git_ps1)'
else
    GITPS=''
fi

PS1="$HOST_WARNING_COLOR\n\e[38;5;255m[\t] $HOST_COLOR\u@\h \e[38;5;118m\w${GITPS}\e[0m\n\\$ "

if [ -f ~/.extras ]; then
    source ~/.extras
fi
