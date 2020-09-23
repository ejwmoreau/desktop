# Desktop

## Overview

These are my dotfiles that I am using on a daily basis.

It comes with a number of Ansible roles that setup my dotfiles and config.

Some of the contents include:

* Terminal Coloring
* Xresources
* lightdm
* bashrc
* vim
* awesome wm

## Installation

* `sudo pacman -Sy ansible`
* `make`

## Adding Content From Other Repos

Add an ansible role or tasks to include:
* Cloning the repo
* Linking the repo contents in the relevant destination

# Implicit Contributors

* Created most of the dotfile + config content
  * [Scott Greenup](https://github.com/scottgreenup/desktop)
* Helped with Ansible setup
  * [Oliver Dolbeau](https://odolbeau.fr/blog/how-to-install-your-laptop-with-ansible.html)
  * [Alexandre Carlton](https://github.com/AlexandreCarlton/ansible-archlinux)
