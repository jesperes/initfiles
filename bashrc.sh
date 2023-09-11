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

if [ "${BASH_VERSINFO[0]}" -gt 4 ]; then
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

# See https://stackoverflow.com/questions/54833752/how-to-silence-paramiko-cryptographydeprecationwarnings-in-ansible
export PYTHONWARNINGS=ignore::UserWarning
export RUST_BACKTRACE=1

#
# Aliases
alias ls='ls -l --color'
alias sweep='find -type f -name \*~ -exec rm -vf {} \;'
alias cat='batcat'

upgrade() {
    cd "$HOME"/initfiles/ansible && make
}

export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

# Keychain
for key in id_rsa id_rsa_bitbucket ; do
    echo $key
    /usr/bin/keychain "$HOME"/.ssh/$key
done
source "$HOME/.keychain/$HOSTNAME-sh"

# kubectl autocompletion
source <(kubectl completion bash)

export PGUSER=postgres
export PGHOST=kred-ci-test-results.chmdfzrgmnrd.eu-west-1.rds.amazonaws.com
export JIRA_USER=sys.kred.ci.jenkins
export AWS_PROFILE=default

init_kred() {
    lib/kdb/priv/remove_s3_mock.sh
    lib/kdb/priv/create_s3_mock.sh
    lib/pgsql_db/priv/remove_postgres.sh
    lib/pgsql_db/priv/create_postgres.sh
    export DB_URI="postgres://postgres:mysecretpassword@localhost:5432/kred"
    bin/kred "${@}" -cluster_id 1 -n postgres
}

aws_menu () {
    # -d 14400 means 4 hours, wich is the max allowed duration
    # shellcheck disable=SC2046
    eval $(aws-login-tool login $(aws-login-tool list-roles -u "$LDAP_USER" -m | peco) -d 14400 -u "$LDAP_USER")
}

aws_login() {
    ROLE=iam-sync/kred/kred.IdP_core

    case $1 in
        production|live)
            ACCOUNT=203244189820
            ;;
        nonprod*|staging)
            ACCOUNT=466078361986
            ;;
        prod-internal|verif)
            ACCOUNT=035412085684
            ;;
        *)
            echo "Usage: aws_login [production|nonprod|prod-internal]"
            exit 1
            ;;
    esac

    # shellcheck disable=SC2046
    eval $(aws-login-tool login -u "$LDAP_USER" -d 14400 -r $ROLE -a $ACCOUNT)
}

. "$HOME/.cargo/env"

eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
