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

alias ls='ls -l --color=auto'
alias sweep='find -name \*~ -exec rm -v {} \;'
export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\t \[$(tput setaf 2)\][\[$(tput setaf 5)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 6)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\]\\$ \[$(tput sgr0)\]"

PATH="/home/jesperes/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jesperes/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jesperes/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jesperes/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jesperes/perl5"; export PERL_MM_OPT;
