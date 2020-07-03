#!/usr/bin/env bash

set +x

git submodule update --init --recursive

cwd=$(pwd)

function checkfile() {
    filename=${1}
    if [[ -e "${filename}" ]]; then
        if [[ ! -h "${filename}" ]]; then
            mv "${filename}" "${filename}.backup"
            echo "${filename} -> ${filename}.backup"
        else
            rm "${filename}"
        fi
    fi
}

#===============================================================================
# Color
#-------------------------------------------------------------------------------
checkfile "${HOME}/.config/base16-shell"
ln -sT\
    "${cwd}/submodules/github.com/chriskempson/base16-shell"\
    "/${HOME}/.config/base16-shell"
#===============================================================================

## [ Miscellaneous ] ##

checkfile "${HOME}/.Xmodmap"
ln -sfT "${cwd}/home/xmodmaprc"  "${HOME}/.Xmodmap"
checkfile "${HOME}/.git-completion.bash"
ln -sfT "${cwd}/home/git-completion.bash" "${HOME}/.git-completion.bash"

mkdir --parents "${HOME}/.urxvt/ext"
checkfile "${HOME}/.urxvt/ext/font-size"
ln -sTf\
    "${cwd}/submodules/github.com/majutsushi/urxvt-font-size/font-size"\
    "${HOME}/.urxvt/ext/font-size"

