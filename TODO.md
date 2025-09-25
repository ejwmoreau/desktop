# Todo List

## Platform Agnostic

* Finish going through Scott's vimrc for anything I want to keep
* Add extensions for VSCode (Python, Atlassian, Yaml, Vim)
* Add extensions for IntelliJ (Even just a manual list of them)
* Add Firefox tab groups and such
* Contribute the change to `base16-vim` repo, or at least keep a forked repo with the change
* Use the existing `base16` theme in more places (intellij, i3, i3status, etc)

### Adding to Ansible

* There's some TODOs throughout the Ansible tasks
* Consider converting some manual steps (`debug` tasks) into Ansible tasks
* Add nvm & npm setup
* Add java & jre setup
* VSCode settings & preferences. Notable files:
  * `~/.config/Code/User/settings.json`
  * `~/.config/Code/User/globalStorage/storage.json` (although it also contains some highly variable config. E.g: open windows, etc)

### zsh

* Convert bashrc to zshrc (as best as I can)
* See if I need to use oh-my-zsh. What benefits do I get?
* Change from zplug to another zsh plugin manager that is maintained
  * https://wiki.archlinux.org/title/zsh#Plugin_managers
* Consider removing bash if I'm not going to use it anymore

## Mac

* Improve wallpaper choices, ideally a random wallpaper out of many options in a folder
* Create a `brew` upgrade script that runs a few different "upgrade" commands
  * `brew update`
  * `brew upgrade`
  * `brew upgrade --cask --greedy` (to upgrade all the casks, including ones that don't have a "version")
* `spicetify` install & setup
  * https://formulae.brew.sh/formula/spicetify-cli
  * Adblock extension: https://github.com/rxri/spicetify-extensions/blob/main/adblock/README.md

### Adding to Ansible

* Manually export all the Amethyst settings I've tweaked into a config file:
  * https://github.com/ianyh/Amethyst/blob/development/docs/configuration-files.md
  * It seems like there might be some synchronisation issues with the config file?
    * It might be best to try and only edit the config file from now on, so it always loads the settings from there
  * https://github.com/ianyh/Amethyst/blob/development/.amethyst.sample.yml

## Linux

* Change login logos to Arch logo
* Add and use `peek` for screen recording
* Use this for lightdm greeter
  * https://github.com/NoiSek/Aether
* Figure out if there's a faster alternative to LightDM. If not, then it might be something I just need to accept
* Move to another notification system, so then I can dismiss notifications with particular IDs
  * Also to be able to pause notifications when I'm in a meeting or something
* Write a short doc about `systemd-analyse`, like the commands here: https://www.techrepublic.com/article/how-to-analyze-systemd-boot-performance/
  * `systemd-analyse`, `systemd-analyse blame`, `systemd-analyse critical-chain`
* Figure out why the keyboard doesn't seem to be fully connected/working at the start of resuming from hibernation (& suspension sometimes)
  * It eventually works, but it would be nice to have a proper signal of when it's not ready for me to type, instead of me trying to type for 5~10 seconds
* Write a script to easily turn on/off the GPU without rebooting. Not sure if it's possible
* Improve wallpaper by picking a random one from a folder or something. Maybe change on schedule?
* Improve dunst notifications
  * Improve their look, maybe even on a per app basis (Spotify, Slack, Google Calendar, etc)
  * Add notification when battery is below 15%
  * Don't dismiss all notifications when dismissing one of them
  * Improve how visible calendar notifications are, so I don't miss meetings
  * Sometimes calendar notifications don't happen?
* Update bluetooth_battery to pick the red colour from Xresources colours
* Add notification icons for the volume & brightness & battery notifications
* Improve `check_battery` script, and run it on a systemd timer
* Tweaking icon theme used by GTK and other applications
  * Installed `papirus-icon-theme` for a decent icon theme
  * Tweaked `~/.config/gtk-3.0/settings.ini` to change the icon theme, but not sure what effect it had
  * Installed `lxappearance-gtk3` to try and set the default icon theme, but couldn't figure out how to use it
    * Might uninstall this one later
  * `xournalpp` isn't complaining anymore, so at the very least the `papirus` icons are being used as a backup
* Switch to `systemd-boot` or something simpler than GRUB
* Improve colour scheme of rofi. It looks decent atm, but a bit of colour would be nice
  * Maybe some blue? Or maybe go for a Nord theme?
* Consider adding `run` and/or `ssh` modes for rofi
  * Should they be altogether in a combined mode? Or a different shortcut?
* Add the `/etc/sudoers.d/openconnect` file to ansible

### Adding to Ansible

* Add setup for swap (for hibernation to work)
  * Using a swapfile within the encrypted volume
  * https://wiki.archlinux.org/title/Swap#Swap_file
  * Also set swapiness to 1 (very low number) so it'll avoid using swap normally
  * No need to encrypt the swap itself
* Add setup for hibernation
  * Kernel parameters, then re-gen grub config
  * Configure the initramfs hooks, then mkinitcpio
* Add `nautilus`
  * Also run this command to set it as default: `xdg-mime default org.gnome.Nautilus.desktop inode/directory`
* Add `noisetorch` for some noise cancellation on any audio inputs (e.g: mic)
  * Need to prompt the user to load it via the UI. Maybe this needs to be done after every reboot as well?
  * Need to test if a low threshold works or not. The audio seemed to sometimes cut out my voice
* Add a mention somewhere to change UEFI settings for battery usage to "Primarily AC", so it can improve battery health
* Add flatpak and all the packages I have
* Add some minimal config for root (e.g: vimrc & bashrc) so then some root commands or ttys are nicer
* Add notification when changing screen brightness

### i3

* Various TODOs in the i3 config
* Maybe use scratchpad as a way to "minimise" some windows
  * https://i3wm.org/docs/userguide.html#scratchpad
  * https://www.reddit.com/r/i3wm/comments/9zpumb/any_way_to_hide_a_window/
* Try the `[workspace=x]` criteria idea, to move a workspace to the current output:
  * https://www.reddit.com/r/i3wm/comments/56ayg3/i3msg_moving_a_specific_workspace_to_another/
* Polish & Practice using window keybindings
* Polish & Practice using workspace keybindings
* Window/Client border & looks
* Moving workspaces to the current output
* Obsidian is missing it's title bar for some reason :/
  * It has a titlebar when in tabbed mode, but not vertical or horizontal
* Continue on `bin/calendar_status` & `bin/prettify_calendar_notifications` for future Linux setup
