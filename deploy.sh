#!/usr/bin/env bash

set +x

git submodule update --init --recursive

cwd=$(pwd)

#===============================================================================
# Color
#-------------------------------------------------------------------------------
ln -sT\
    "${cwd}/submodules/github.com/chriskempson/base16-shell"\
    "/${HOME}/.config/base16-shell"
#===============================================================================

## [ Miscellaneous ] ##

ln -sfT "${cwd}/home/xmodmaprc"  "${HOME}/.Xmodmap"
ln -sfT "${cwd}/home/git-completion.bash" "${HOME}/.git-completion.bash"
