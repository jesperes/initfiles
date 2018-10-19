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
# lsb_release is included by default on Ubuntu, but needs package
# "redhat-lsb-core" on Fedora-derivatives.
DISTRO_NAME=`lsb_release -i -s`-`lsb_release -r -s`

#
# Bash completion, if available
case $DISTRO_NAME in
    Ubuntu*)
        if [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
        ;;
    Fedora*)
        # skip bash completion on fedora until I can get it to work.
        ;;
    *)
        ;;
esac

#
# Exported variables 
export EDITOR=emacs
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export MAKEFLAGS="-j`nproc`"
export ERL_AFLAGS="-kernel shell_history enabled"

#
# Kred
export ERL_INETRC=$HOME/.inetrc
# export PROGRESS='@echo $(@F) "<-" $^'

#
# Use ccache if installed
export PATH=/usr/lib/ccache:$PATH

#
# Aliases
# alias make='make -s'
alias ls='ls -l --color=auto'
alias sweep='find -type f -name \*~ -exec rm -vf {} \;'
alias vpnup='nmcli con up id Klarna'
alias vpndown='nmcli con down id Klarna'
alias make='nice make'

source $HOME/dev/git/contrib/completion/git-prompt.sh

#
# Bash prompt
#BOLD="\[`tput bold`\]"
#FG1="\[`tput setaf 1`\]" # red
#FG2="\[`tput setaf 2`\]" # green
#FG3="\[`tput setaf 3`\]" # yellow
#FG4="\[`tput setaf 4`\]" # blue
#FG5="\[`tput setaf 5`\]" # purple
#FG6="\[`tput setaf 6`\]" # cyan
#SGR0="\[`tput sgr0`\]"   # clear formatting
#PS1=""
#PS1="$PS1$BOLD"     # entire prompt is bold
#PS1="$PS1$FG6\t "   # time (cyan)
#PS1="$PS1$FG2["     # '[' (green)
#PS1="$PS1$FG5\u"    # username (purple)
#PS1="$PS1$FG1@"     # '@' (red)
#PS1="$PS1$FG4\h "    # hostname (blue)
# PS1="$PS1$FG4$DISTRO_NAME " # distro name (yellow)
#PS1="$PS1$FG6\w"    # path (cyan)
#PS1="$PS1$FG2]"     # ']' (green)
#PS1="$PS1$FG4\\$ "  # '$' (blue)
#PS1="$PS1$SGR0"

GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
GIT_PROMPT_FETCH_REMOTE_STATUS=1
GIT_PROMPT_IGNORE_SUBMODULES=1 # speeds up the prompt
GIT_PROMPT_THEME=Single_line_Dark

source ~/dev/bash-git-prompt/gitprompt.sh 
 
