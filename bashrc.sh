# 
# Bash init file. Symlinked from $HOME/.bashrc.
#

# Don't do anything if we are not running interactively
[ -z "$PS1" ] && return

shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s dirspell
shopt -s globstar

#
# Put local customizations in $HOME/.bashrc_local, like local PATH settings.
if [ -f $HOME/.bashrc_local ]; then
    . $HOME/.bashrc_local
fi

#
# Exported variables 
export EMACS=emacs
export SVN_EDITOR=$EDITOR
export WINEDEBUG=fixme-all
export MAKEFLAGS=-j8
eval `gnome-keyring-daemon`

#
# Aliases
if [ `uname -s` = Linux ]; then
    alias git='eval `gnome-keyring-daemon` && git'
    alias svn='eval `gnome-keyring-daemon` && svn'
fi
alias ls='ls -l --color=auto'
alias sweep='find -name \*~ -exec rm -v {} \;'
