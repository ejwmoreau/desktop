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


## [ Awesome WM ] ##

mkdir --parents "${HOME}/.config/awesome"
checkfile "${HOME}/.config/awesome/rc.lua"
ln -sTf "${cwd}/home/config/awesome/rc.lua" "${HOME}/.config/awesome/rc.lua"
ln -sTf "${cwd}/home/config/awesome/themes" "${HOME}/.config/awesome/themes"

checkfile "${HOME}/.config/awesome/assault.lua"
ln -sfT\
    "${cwd}/submodules/github.com/NuckChorris/assault/awesomewm/assault.lua"\
    "${HOME}/.config/awesome/assault.lua"

ln -sTf\
    "${cwd}/submodules/github.com/scottgreenup/lain"\
    "${HOME}/.config/awesome/lain"

ln -sTf\
    "${cwd}/submodules/github.com/Mic92/vicious"\
    "${HOME}/.config/awesome/vicious"

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

