# Todo List

* Complete Ansible roles with all the current dotfiles and config in the repo
* Add proper AUR package download via yay in Ansible
* Split some of the packages in `common` to their own roles/tasks
* There's some TODOs throughout the Ansible tasks
* Add nvm & npm setup
* Add java & jre setup
* Add extensions for VSCode (Python, Atlassian, Yaml, Vim)
* (Maybe) Add virtualbox setup for Paprika?
* Add Firefox tab groups and such
* Change login logos to Arch logo
* Install kernel-modules-hook from AUR
  * 2 commands to run afterwards (prompted by yay install message):
    * sudo systemctl daemon-reload
    * sudo systemctl enable linux-modules-cleanup

## Awesome WM

* Keep the same focused window when changing layouts
  * E.g: When changing from multi-tiled to single-tiled, then keep the same focused client
* Improve focus when moving a client from one screen to another
  * Default to focusing on something on the current screen, or
  * Default to keeping focus on the client being moved (but what if the screen is not visible?)
