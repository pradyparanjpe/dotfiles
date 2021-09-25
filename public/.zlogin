# shellcheck shell=sh

# shellcheck source=.local/share/pspman/src/runcom/zshrc
if [ -f "${RUNCOMDIR}/zlogin" ]; then
    # shellcheck disable=1091
    . "${RUNCOMDIR}/zlogin"
fi

