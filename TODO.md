# Todo List

* Finish going through Scott's vimrc for anything I want to keep
* Add extensions for VSCode (Python, Atlassian, Yaml, Vim)
* Add Firefox tab groups and such
* Change login logos to Arch logo
* Add and use `peek` for screen recording
* Use this for lightdm greeter
  * https://github.com/NoiSek/Aether
* Figure out if I need the config changes at the end of `/etc/pulse/default.pa.pacsave`
  * https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Enable_Echo/Noise-Cancellation
* Contribute the change to `base16-vim` repo, or at least keep a forked repo with the change
* Volume indicator when muting/changing volume, so it's clear what volume it's currently on
  * Ideally, this would be handled by some sort of tool/service, instead of writing my own thing
* See if there's some config in `/etc/systemd/logind.conf` that allows for suspending + hibernating after a long idle time (1+ hours)
  * Is this more useful than configuring it in `xidlehook`? Probably, so then it triggers when manual locking too
* Move to another notification system, so then I can dismiss notifications with particular IDs

## Adding to Ansible

* Split some of the packages in `common` to their own roles/tasks
* There's some TODOs throughout the Ansible tasks
* Consider converting some manual steps (`debug` tasks) into Ansible tasks
* Add nvm & npm setup
* Add java & jre setup
* Add setup for swap (for hibernation to work)
  * Using a swapfile within the encrypted volume
  * https://wiki.archlinux.org/title/Swap#Swap_file
  * Also set swapiness to 1 (very low number) so it'll avoid using swap normally
  * No need to encrypt the swap itself
* Add setup for hibernation
  * Kernel parameters, then re-gen grub config
  * Configure the initramfs hooks, then mkinitcpio
* Add changes to `/etc/systemd/logind.conf` & `/etc/systemd/sleep.conf`, for the laptop lid close actions
* Add edits to `/etc/pacman.conf` to uncomment `#Color` and add `ILoveCandy` under it
  * Color is much better, and `ILoveCandy` makes the progress bars into pacman eating circles
* Add `reflector`
  * Including config changes to `/etc/xdg/reflector/reflector.conf`
  * Including the pacman hook from https://wiki.archlinux.org/title/Reflector
* Add `nautilus`
  * Also run this command to set it as default: `xdg-mime default org.gnome.Nautilus.desktop inode/directory`
* Add `noisetorch` for some noise cancellation on any audio inputs (e.g: mic)
  * Need to prompt the user to load it via the UI. Maybe this needs to be done after every reboot as well?
  * Need to test if a low threshold works or not. The audio seemed to sometimes cut out my voice
* Add a mention somewhere to change UEFI settings for battery usage to "Primarily AC", so it can improve battery health
* Add flatpak and all the packages I have
* Add some minimal config for root (e.g: vimrc & bashrc) so then some root commands or ttys are nicer
* If I like it, add `blueman` to the bluetooth stuff, so I have a decent UI to manage bluetooth connections, instead of CLI
* Change nm-applet's autostart file to use `Exec=env GDK_SCALE=1 nm-applet` for HiDPI
* Add some checks before running some time-consuming tasks, in case some time can be saved when running `make`

## Awesome WM

* Keep the same focused window when changing layouts
  * E.g: When changing from multi-tiled to single-tiled, then keep the same focused client
* Improve focus when moving a client from one screen to another
  * Default to focusing on something on the current screen, or
  * Default to keeping focus on the client being moved (but what if the screen is not visible?)
