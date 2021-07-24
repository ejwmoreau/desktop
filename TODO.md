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
* Add the config changes at the end of `/etc/pulse/default.pa`
  * https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting#Enable_Echo/Noise-Cancellation
* Add setup for swap (for hibernation to work)
  * Using a swapfile within the encrypted volume
  * https://wiki.archlinux.org/title/Swap#Swap_file
  * Also set swapiness to 1 (very low number) so it'll avoid using swap normally
  * No need to encrypt the swap itself
* Add setup for hibernation
  * Kernel parameters, then re-gen grub config
  * Configure the initramfs hooks, then mkinitcpio
* Change laptop lid close to use hybrid-sleep, so it'll be able to resume even if the laptop dies
  * Changes are appended to /etc/systemd/logind.conf
* Turn on TRIM for SSD
  * Enable trim timer `systemctl enable fstrim.timer`
  * Add `:allow-discards` and `rd.luks.options=discard`: https://wiki.archlinux.org/title/Dm-crypt/Specialties#Discard/TRIM_support_for_solid_state_drives_(SSD)
* Some `INTEL_GPU_*` settings in `/etc/tlp.conf`
  * Maybe also other settings in that file
  * Not sure where the magic numbers come from, but try search in #linux for them
* Install and use `https://aur.archlinux.org/packages/bluetooth-headset-battery-level-git`
  * To get Bluetooth headset battery levels. The script might need to run twice
  * `bluetooth-headset-battery-level CC:98:8B:B7:2A:0E`
* Edit `/etc/pacman.conf` to uncomment `#Color` and add `ILoveCandy` under it
  * Color is much better, and `ILoveCandy` makes the progress bars into pacman eating circles
* Consider getting `rebind_dock_usb` to run after logging back in via i3lock
  * If there's some symptom that I can check for, that would help too
* Add udev rules to Ansible setup (under etc/udev)

## Awesome WM

* Keep the same focused window when changing layouts
  * E.g: When changing from multi-tiled to single-tiled, then keep the same focused client
* Improve focus when moving a client from one screen to another
  * Default to focusing on something on the current screen, or
  * Default to keeping focus on the client being moved (but what if the screen is not visible?)

## Experiments

* Using `DRI 2` for Intel Graphics driver:
  * https://unix.stackexchange.com/questions/524205/help-chromium-display-frozen-but-the-app-keeps-working
  * Trying to stop the occasional freezing with Chrome/Slack/Obsidian
  * Added `/etc/X11/xorg.conf.d/20-intel.conf`
  * If it doesn't work, then maybe try using `AccelMethod UXA`: https://bugs.chromium.org/p/chromium/issues/detail?id=370022#c83
  * Result: `DRI 2` made Spotify not update it's UI much, so the overall result was worse
* Using `mem_sleep_default=deep` in kernel parameters:
  * Trying to see if it improves sleep: https://hello.atlassian.net/wiki/spaces/Linux/pages/1177109787/Getting+the+laptop+to+really+suspend
  * Result: It seems like deep sleep doesn't work well for my laptop, so it's probably better to revert
* Disabling power management via TLP for the Dell dock:
  * Created this file: /etc/tlp.d/01-tb16.conf
  * Result: It might help a bit, but it doesn't force the kernel to disable power management for the dock
