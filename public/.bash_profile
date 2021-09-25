# .bash_profile
# shellcheck shell=sh
# Get the aliases and functions
# User specific environment and startup programs

# shellcheck source=".profile"
if [ -f "${HOME}"/.profile ]; then
    # shellcheck disable=SC1091
    . "${HOME}"/.profile
fi

if [ -f "${HOME}"/.bashrc ]; then
    # shellcheck disable=SC1091
    . "${HOME}"/.bashrc
fi

# shellcheck source=".local/share/pspman/src/runcom/bash_login"
if [ -f "${HOME}/.runcom/bash_login" ]; then
    # shellcheck disable=SC1091
    . "${HOME}/.runcom/bash_login"
fi

