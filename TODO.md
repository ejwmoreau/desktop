# Todo List

* Complete Ansible roles with all the current dotfiles and config in the repo
* Add proper AUR package download via yay in Ansible
* Split some of the packages in `common` to their own roles/tasks
* There's some TODOs throughout the Ansible tasks
* Add the autorandr section below to Ansible
* Add nvm & npm setup
* Add java & jre setup
* Add repo for work-related things (including atlas)
* Add python virtualenvwrapper setup
* Add sound + bluetooth setup
* Add yay setup

## Autorandr

`sudo make install TARGETS="bash_completion systemd udev manpage"`

And tell the user to run commands that autorandr asks to run after installation
