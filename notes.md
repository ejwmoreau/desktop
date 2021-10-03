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
  * Result: WIP, but I haven't had a freeze yet!

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
