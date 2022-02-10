# Todo List

* Finish going through Scott's vimrc for anything I want to keep
* Add extensions for VSCode (Python, Atlassian, Yaml, Vim)
* Add Firefox tab groups and such
* Change login logos to Arch logo
* Add and use `peek` for screen recording
* Use this for lightdm greeter
  * https://github.com/NoiSek/Aether
* Contribute the change to `base16-vim` repo, or at least keep a forked repo with the change
* Volume indicator when muting/changing volume, so it's clear what volume it's currently on
  * Ideally, this would be handled by some sort of tool/service, instead of writing my own thing
* See if there's some config in `/etc/systemd/logind.conf` that allows for suspending + hibernating after a long idle time (1+ hours)
  * Is this more useful than configuring it in `xidlehook`? Probably, so then it triggers when manual locking too
* Move to another notification system, so then I can dismiss notifications with particular IDs
  * Also to be able to pause notifications when I'm in a meeting or something
* Write a short doc about `systemd-analyse`, like the commands here: https://www.techrepublic.com/article/how-to-analyze-systemd-boot-performance/
  * `systemd-analyse`, `systemd-analyse blame`, `systemd-analyse critical-chain`
* Figure out if there's a faster alternative to LightDM. If not, then it might be something I just need to accept
* Figure out why the keyboard doesn't seem to be fully connected/working at the start of resuming from hibernation (& suspension sometimes)
  * It eventually works, but it would be nice to have a proper signal of when it's not ready for me to type, instead of me trying to type for 5~10 seconds
* Write a script to easily turn on/off the GPU, so I can use it when needed
  * See if there's a way to avoid rebooting. Otherwise it might not be possible
* Consider switching to zsh + powerlevel10k, since it looks pretty good
* Improve wallpaper by picking a random one from a folder or something. Maybe change on schedule?

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
* Add `nautilus`
  * Also run this command to set it as default: `xdg-mime default org.gnome.Nautilus.desktop inode/directory`
* Add `noisetorch` for some noise cancellation on any audio inputs (e.g: mic)
  * Need to prompt the user to load it via the UI. Maybe this needs to be done after every reboot as well?
  * Need to test if a low threshold works or not. The audio seemed to sometimes cut out my voice
* Add a mention somewhere to change UEFI settings for battery usage to "Primarily AC", so it can improve battery health
* Add flatpak and all the packages I have
* Add some minimal config for root (e.g: vimrc & bashrc) so then some root commands or ttys are nicer

## Moving from Awesome WM to i3

* Things still to migrate/improve:
  * Window/Client border & looks
  * Notification customisation (not sure how to do this)
* Make sure it works as intended for a multi-display setup
  * How to workspaces get moved over there?

## i3

* Various TODOs in the i3 config
* Maybe use scratchpad as a way to "minimise" some windows
  * https://i3wm.org/docs/userguide.html#scratchpad
  * https://www.reddit.com/r/i3wm/comments/9zpumb/any_way_to_hide_a_window/
* Try the `[workspace=x]` criteria idea, to move a workspace to the current output:
  * https://www.reddit.com/r/i3wm/comments/56ayg3/i3msg_moving_a_specific_workspace_to_another/
* Fix general `notify-send` notifications
* Polish & Practice using window keybindings
* Polish & Practice using workspace keybindings

## Awesome WM

* Keep the same focused window when changing layouts
  * E.g: When changing from multi-tiled to single-tiled, then keep the same focused client
* Improve focus when moving a client from one screen to another
  * Default to focusing on something on the current screen, or
  * Default to keeping focus on the client being moved (but what if the screen is not visible?)
