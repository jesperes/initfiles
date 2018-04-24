# 
# Bash init file. Symlinked from $HOME/.bashrc.
#

# Don't do anything if we are not running interactively
[ -z "$PS1" ] && return

shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
if [ $BASH_VERSINFO[0] == 4 ]; then
    shopt -s dirspell
    shopt -s globstar
fi

#
# Put local customizations in $HOME/.bashrc_local, like local PATH settings.
if [ -f $HOME/.bashrc_local ]; then
    . $HOME/.bashrc_local
fi

#
# Exported variables 
export EDITOR=emacs
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export MAKEFLAGS=-j8

#
# Use ccache if installed
export PATH=/usr/lib/ccache:$PATH

alias ls='ls -l --color=auto'
alias sweep='find -type f -name \*~ -exec rm -vf {} \;'

#
# Git prompt
# GIT_PROMPT_ONLY_IN_REPO=1
source ~/dev/bash-git-prompt/gitprompt.sh 

#
# Interactive prompt.
# export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\t \[$(tput setaf 2)\][\[$(tput setaf 5)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 6)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"

