# shellcheck shell=sh
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash

if [ -f "${HOME}/.config/varrc" ]; then
    # shellcheck disable=SC1091
    . "${HOME}/.config/varrc"
fi

# shellcheck source=".local/share/pspman/src/runcom/profile"
if [ -f "${HOME}/.runcom/profile" ]; then
    # shellcheck disable=SC1091
    . "${HOME}/.runcom/profile"
fi


### PSPMAN MOD ###
# shellcheck source=".config/pspman/profile"
if [ -f "${HOME}/.config/pspman/profile" ]; then
    # shellcheck disable=SC1091
    . "${HOME}/.config/pspman/profile"; fi
### PSPMAN MOD ###


### PSPMAN MOD ###
# shellcheck source=".config/pspman/profile"
if [[ -f "${HOME}/.config/pspman/profile" ]]; then
    # shellcheck disable=SC1091
    . "${HOME}/.config/pspman/profile"; fi
### PSPMAN MOD ###
