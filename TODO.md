# Todo List

* Complete Ansible roles with all the current dotfiles and config in the repo
* Add the following packages:
    * dmenu2 (AUR)
    * perl-clipboard (AUR)
* Split some of the packages in `common` to their own roles/tasks
* There's some TODOs throughout the Ansible tasks
* Add the autorandr section below to Ansible

## Autorandr

`sudo make install TARGETS="bash_completion systemd udev manpage"`

And the commands that autorandr asks to run (or tell the user to run commands that autorandr asks to run)
