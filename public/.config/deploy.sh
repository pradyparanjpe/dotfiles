#!/usr/bin/env sh

set_vars () {
    commit=false
    config="${XDG_CONFIG_HOME:-${HOME}/.config}"
    config_sync_dir="$(readlink -f "$(dirname "$0")")"
    cdds="alacritty chemacs foot gammastep gtk-2.0 gtk-3.0 gtk-4.0 mpv \
matplotlib nvim procps procs psprint qutebrowser rcfiles youtube-dl zathura"
    cdfs="varrc pylintrc ppstencil.yml"
    hdfs="bash_login bash_profile bashrc profile pypirc zlogin zprofile \
zshrc vimrc"
    # colors
    yok="\033[33;40m"
    bok="\033[34;40m"
    dod="\033[m"
    usage="
    usage: ${0} -h
    usage: ${0} --help
    usage: ${0} [-c|--commit]
"
    help_msg="${usage}

    Optional Arguments:
    -h\t\tprint usage message and exit
    --help\tprint this help message and exit
    -c|--commit\tcommit changes to filesystem (default action: dry run)
"
}

unset_vars() {
    unset commit
    unset config
    unset config_sync_dir
    unset gok
    unset yok
    unset bok
    unset dod
    unset cdds
    unset cdfs
    unset hdfs
    unset help_msg
    unset usage
}

clean_exit() {
    unset_vars
    if [ -n "${1}" ]; then
        printf "Failed\n" >&2
        # shellcheck disable=SC2086
        exit $1
    fi
    exit 0
}

cli () {
    while [ $# -gt 0 ]; do
        case "${1}" in
            -h)
                # shellcheck disable=SC2059
                printf "${usage}\n"
                clean_exit
                ;;
            --help)
                # shellcheck disable=SC2059
                printf "${help_msg}\n"
                clean_exit
                ;;
            -c|--commit)
                commit=true
                shift
                ;;
            *)
                # shellcheck disable=SC2059
                printf "Bad command usage: %s\n${usage}\n" "${1}"
                clean_exit 3
        esac
    done
}


linkdirs () {
    # link config directories
    if $commit; then
        mkdir -p "${config}" || clean_exit 1
    fi
    printf "mkdir -p ${bok}%s${dod}\n" "${config}"

    for confdir in ${cdds}; do
        printf "${bok}%s${dod} ->  %s\n" \
               "${config}/${confdir}" "${config_sync_dir}/${confdir}"
        if $commit; then
            if [ -L "${config}/${confdir}" ]; then
                continue;
            fi
            ln -sf "${config_sync_dir}/${confdir}" "${config}/${confdir}"\
                || clean_exit 1
        fi
    done
}

linkfiles () {
    # link config files
    for conffile in ${cdfs}; do
        printf "${yok}%s${dod} -> %s\n" "${config}/${conffile}" \
            "${config_sync_dir}/rcfiles/${conffile}"
        if $commit; then
            if [ -L "${config}/${conffile}" ]; then
                continue;
            fi
            ln -sf "${config_sync_dir}/rcfiles/${conffile}" \
                "${config}/${conffile}" || clean_exit 1
        fi
    done
}


linkrc () {
    # shell rc files
    for shrcf in ${hdfs}; do
        printf "${yok}%s${dod} -> %s\n" \
            "${HOME}/.${shrcf}" "${config}/rcfiles/${shrcf}"
        if $commit; then
            if [ -L "${HOME}/.${shrcf}" ]; then
                continue;
            fi
            ln -sf "${config}/rcfiles/${shrcf}" "${HOME}/.${shrcf}"\
                || clean_exit 1
        fi
    done
    unset confdir
    unset conffile
    unset shrcf
    unset
}

main () {
    set_vars
    cli "$@"
    # shellcheck disable=SC2059
    $commit || printf "\033[31;40mDRY${dod}:\n"
    linkdirs
    linkfiles
    linkrc
    # shellcheck disable=SC2059
    if $commit; then
        printf "\033[32;40msuccess${dod}\n"
    fi
    clean_exit
}

main "$@"
