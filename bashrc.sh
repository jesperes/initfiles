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
export WINEDEBUG=fixme-all
export MAKEFLAGS=-j8
# eval `gnome-keyring-daemon`

#
# Aliases
#if [ `uname -s` = Linux ] && [ -f /usr/bin/gnome-keyring-daemon ]; then
    #alias git='eval `/usr/bin/gnome-keyring-daemon` && git'
    #alias svn='eval `/usr/bin/gnome-keyring-daemon` && svn'
#fi

alias ls='ls -l --color=auto'
alias sweep='find -name \*~ -exec rm -v {} \;'
