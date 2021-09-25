# shellcheck shell=sh
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=3
zstyle ':completion:*' select-prompt %SScrolling \
    active: current selection at %p%s
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install


# shellcheck source=".local/share/pspman/src/runcom/zshrc"
if [ -f "${RUNCOMDIR}/zshrc" ]; then
    # shellcheck disable=1091
    . "${RUNCOMDIR}/zshrc"
fi

