# Desktop

## Overview

This repo contains a bunch of dotfiles & settings:

* I use them on a daily basis
* They are organised into a number of Ansible roles for easy setup
* They contain variants for both MacOS & Linux

Some of the contents include:

* Package Managers (pacman, homebrew)
* Desktop Environments (i3, amethyst)
* Applications (kitty, intellij)
* Input / Output Devices (sound, bluetooth)
* Scripts (bin)

## Installation

1. Install Ansible: `./bin/setup.sh`
2. Install Ansible modules: `make setup`
3. Install everything else: `make`

## How To Add Content From Other Repos

Add an Ansible role or tasks to include:
* Cloning the repo
* Linking the repo contents in the relevant destination

## Implicit Contributors

* Created most of the dotfile + config content
  * [Scott Greenup](https://github.com/scottgreenup/desktop)
* Helped with Ansible setup
  * [Oliver Dolbeau](https://odolbeau.fr/blog/how-to-install-your-laptop-with-ansible.html)
  * [Alexandre Carlton](https://github.com/AlexandreCarlton/ansible-archlinux)
