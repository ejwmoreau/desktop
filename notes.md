# Ongoing Experiments

Using systemd-homed

* When I got a new laptop, I started out with using systemd-homed to manage my user
  * There were a lot of nice things about it, and overall I really liked how clean the `homectl` command is
* However, there are a few problems that I have with it:

  1. Entering a failed password causes it to attempt unlocking about 5~6 times, which means a long wait time
    * I raised a bug here, although I'm not 100% sure it's a bug with homed: https://github.com/systemd/systemd/issues/19067

  2. It doesn't seem like `accountservice` recognises homed users, so using any `lightdm-webkit2-greeter`-based display manager is not possible
    * Possibly being tracked here: https://gitlab.freedesktop.org/accountsservice/accountsservice/-/issues/89

  3. Adding a user to a group requires specifying all the user's existing groups in the command
    * Via `homectl update ... --member-of=...`

  4. Using homed makes any auto-login option unavailable, because a password is needed to decrypt the home directory
    * I don't actually mind this, since I've never used auto-login. However, it's worth noting for myself in the future

* All this being said, so far I'm sticking with homed, partially because it'll probably be a pain & risky to migrate away.
  Nothing so far is painful enough to move away from homed, although I might not use it on a fresh install until some of the pain points are fixed

* Tweaked /etc/mkinitcpio.conf hooks to use the systemd hooks, instead of the udev/busybox ones:
  * https://wiki.archlinux.org/title/mkinitcpio#Common_hooks
  * Apparently it should result in a faster boot time. Compare with ~/desktop/systemd-analyse-output-udev.txt if it works
  * Partial result: This change didn't seem to work at all :( It might be a good idea to move away from Grub and simplify the boot process first, before changing the hooks

# Past Experiments

Stopping the window freezes (Chrome/Slack/Obsidian/Firefox)

* Using `DRI 2` for Intel Graphics driver:
  * https://unix.stackexchange.com/questions/524205/help-chromium-display-frozen-but-the-app-keeps-working
  * Trying to stop the occasional freezing with Chrome/Slack/Obsidian
  * Added `/etc/X11/xorg.conf.d/20-intel.conf`
  * If it doesn't work, then maybe try using `AccelMethod UXA`: https://bugs.chromium.org/p/chromium/issues/detail?id=370022#c83
  * Result: `DRI 2` made Spotify not update it's UI much, so the overall result was worse
* Removing the `xf86-video-intel` package, as it's know to cause some freezes
  * https://github.com/awesomeWM/awesome/issues/3241
  * It has stopped the freezes, which is awesome! There's some minor annoyances, but it's pretty decent so far
  * Result: Keep it removed for now, but try with it on again when using i3
* Switching from AwesomeWM to i3
  * I tried installing `xf86-video-intel` again, but within a day the freezing was happening again
  * I'm not actually sure what benefits I'm supposed to get from `xf86-video-intel`
  * Result: I'll stop trying to install `xf86-video-intel` on this laptop

Reducing battery usage during sleep

* Using `mem_sleep_default=deep` in kernel parameters:
  * Trying to see if it improves sleep: https://hello.atlassian.net/wiki/spaces/Linux/pages/1177109787/Getting+the+laptop+to+really+suspend
  * Result: It seems like deep sleep doesn't work well for my laptop, so it's probably better to revert
* Ended up using suspend-then-hibernate + setting UEFI battery setting to "Primarily AC"
  * Result: WIP, but the battery usage is much better now

Stop devices from disconnecting via Dell Dock

* Disabling power management via TLP for the Dell dock:
  * Created this file: /etc/tlp.d/01-tb16.conf
  * Result: It might help a bit, but it doesn't force the kernel to disable power management for the dock
* Ended up stopping to use the Dell dock, and instead using a Caldigit dock

Autorandr

* Tried to see if I can avoid the double trigger when plugging in the dock (1 udev trigger per monitor)
* Result: Whatever the default setup is via `pacman` is the best for me. Don't try the `launcher` option. Live with the double trigger
