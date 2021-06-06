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
* Add and use `peek` for screen recording
* Use this for lightdm greeter
  * https://github.com/NoiSek/Aether
* Remove `enable` for `docker.service`, and instead run this: `systemctl enable --now docker.socket`
  * This will only start docker when it's actually needed, instead of starting on boot
* Add the config changes at the end of `/etc/pulse/default.pa`
  * https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Enable_Echo/Noise-Cancellation
* Add setup for swap (for hibernation to work)
  * Using a swapfile within the encrypted volume
  * https://wiki.archlinux.org/title/Swap#Swap_file
  * Also set swapiness to 10 (low-ish number) so it'll avoid using swap normally
  * No need to encrypt the swap itself
* Add setup for hibernation
  * Kernel parameters, then re-gen grub config
  * Configure the initramfs hooks, then mkinitcpio
* Change suspend and hibernate to "hybrid-sleep", so it'll be able to resume even if the laptop died
  * Changes are appended to /etc/systemd/sleep.conf

## Awesome WM

* Keep the same focused window when changing layouts
  * E.g: When changing from multi-tiled to single-tiled, then keep the same focused client
* Improve focus when moving a client from one screen to another
  * Default to focusing on something on the current screen, or
  * Default to keeping focus on the client being moved (but what if the screen is not visible?)
