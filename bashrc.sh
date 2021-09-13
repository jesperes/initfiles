# shellcheck shell=bash disable=SC1090,SC1091
#
# Bash init file. Symlinked from $HOME/.bashrc.
#

# Don't do anything if we are not running interactively
[ -z "$PS1" ] && return

shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s extglob

if [ "${BASH_VERSINFO[0]}" == 4 ]; then
    shopt -s dirspell
    shopt -s globstar
fi

if [ -f "$HOME"/.bashrc_local ]; then
    . "$HOME"/.bashrc_local
fi

#
# Bash completion, if available
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#
# Exported variables
export EDITOR="emacs -nw -q"
export GIT_EDITOR="$EDITOR"
MAKEFLAGS="-j$(nproc) --output-sync=none"
export MAKEFLAGS
export ERL_AFLAGS="-kernel shell_history enabled"
export BROWSER="google-chrome %u"

#
# Aliases
alias ls='ls -l --color=auto'
alias sweep='find -type f -name \*~ -exec rm -vf {} \;'
alias cat='batcat'
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

# Keychain
for key in id_rsa id_rsa_live; do
    # echo $key
    /usr/bin/keychain -q "$HOME"/.ssh/$key
done
source "$HOME/.keychain/$HOSTNAME-sh"
source "$HOME/dev/git/contrib/completion/git-prompt.sh"

# kubectl autocompletion
source <(kubectl completion bash)

# ------------------------------------------------------------
# Git bash prompt
# ------------------------------------------------------------

GIT_PROMPT_SHOW_UNTRACKED_FILES=no
GIT_PROMPT_FETCH_REMOTE_STATUS=0
GIT_PROMPT_IGNORE_SUBMODULES=1 # speeds up the prompt
source "$HOME/dev/bash-git-prompt/gitprompt.sh"

# ------------------------------------------------------------
# AWS
# ------------------------------------------------------------
prompt_callback() {
    if [[ -n $AWS_PROFILE ]] && [[ $AWS_SESSION_EXPIRATION_TIME -gt $(date +%s) ]]; then
        echo -n "[$AWS_PROFILE ($(( ("$AWS_SESSION_EXPIRATION_TIME" - $(date -u +%s)) / 60)) min)]"
    fi

    kerl prompt
}

aws_menu () {
    # 14400 seconds == 4 hours
    DURATION=14400
    mapfile -t ROLE_ARGS < <(aws-login-tool list-roles -u "$LDAP_USER" -m | peco)
    echo "${ROLE_ARGS[@]}"
    LOGIN_CMD=(aws-login-tool login "${ROLE_ARGS[@]}" -d "$DURATION" -u "$LDAP_USER")
    eval $(${LOGIN_CMD[@]})
}

. "$HOME/.cargo/env"
