#!/usr/bin/env bash

set +x

git submodule update --init --recursive

cwd=$(pwd)

## [ Miscellaneous ] ##

ln -sfT "${cwd}/home/xmodmaprc"  "${HOME}/.Xmodmap"
ln -sfT "${cwd}/home/git-completion.bash" "${HOME}/.git-completion.bash"
