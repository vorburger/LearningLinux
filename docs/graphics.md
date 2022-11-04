# Linux Graphics

**ToDo:** Contribute (some of) this as e.g. https://wiki.archlinux.org/title/Wayland ?

## Introduction & Overview

Wayland ([Wikipedia](https://en.wikipedia.org/wiki/Wayland_(display_server_protocol)),
[Homepage](https://wayland.freedesktop.org), [ArchLinux](https://wiki.archlinux.org/title/Wayland)) is the modern successor to
[the venerable X11](https://en.wikipedia.org/wiki/X_Window_System).

It uses / builds on top of Linux Kernel Mode Setting (KMS)
([Kernel doc](https://www.kernel.org/doc/html/v4.15/gpu/drm-kms.html),
 [freedesktop.org](https://nouveau.freedesktop.org/KernelModeSetting.html),
 [Wikipedia](https://en.wikipedia.org/wiki/Mode_setting),
 [ArchLinux](https://wiki.archlinux.org/title/Kernel_mode_setting)),
which [normall should just work](https://wiki.archlinux.org/title/Kernel_mode_setting#Late_KMS_start) - unless you want to [start it early](https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start):

    $ cat /proc/fb
    0 i915drmfb

    $ sudo dmesg | grep drm
    [    0.342936] ACPI: bus type drm_connector registered
    [    1.752959] systemd[1]: Starting Load Kernel Module drm...
    [    1.790955] systemd[1]: modprobe@drm.service: Deactivated successfully.
    [    1.791179] systemd[1]: Finished Load Kernel Module drm.
    [    1.791560] audit: type=1130 audit(1665849003.912:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
    [    1.791593] audit: type=1131 audit(1665849003.912:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@drm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
    [    3.393187] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
    [    3.410130] fbcon: i915drmfb (fb0) is primary device
    [    4.563095] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device

Wayland is a _protocol._ [Wayland packages](https://archlinux.org/packages/extra/x86_64/wayland/)
just contain shared libraries, and does not contain or have an no dependencies to any
executables that "do" anything (see Package Contents).

Wayland's clients are apps that want to draw pixels on the screen.

The Wayland server, also known as _"compositor"_ actually draws those pixels.
There are a number of such Wayland compositors
([ArchLinux](https://wiki.archlinux.org/title/Wayland#Compositors),
 [Wikipedia](https://en.wikipedia.org/wiki/List_of_display_servers#Wayland)).

[Weston](https://wiki.archlinux.org/title/Weston) is one such _"compositor";_ let's install and try it out, on the console not via SSH:
_(Note how the `weston` package depends e.g. on `wayland`, `libdrm`, `mesa`, `libpng`, `libjpeg`, `libwebp`, `cairo`, `freetype`, `pango` or `pipewire` for sound as well as `libinput` and even `libx11` and more.)_

    sudo pacman -S weston

Click the terminal icon in the upper-left hand corner of the screen, and from there launch:

    weston-flower

You can even launch Weston within Weston! ;-) Ctrl+Alt+Backspace quits Weston.

[Firefox](https://wiki.archlinux.org/title/Firefox#Wayland) seems to work under Wayland;
`about:support` should show `wayland` instead of `x11`.

[Chromium](https://wiki.archlinux.org/title/Chromium#Native_Wayland_support)
currently in v106 works (under Weston) with `--ozone-platform=wayland`
(`--enable-features=UseOzonePlatform` doesn't seem to be required;
 `--ozone-platform-hint=auto` doesn't work); otherwise it fails:
 `missing X server or $DISPLAY`.

[Kitty](https://wiki.archlinux.org/title/Kitty) is a great alternative to `weston-terminal`,
but it initially fails to start with an obscure error under Weston.  But after installing
the alternative [`foot`](https://codeberg.org/dnkl/foot) terminal, and (**ToDo** unclear...)
the alternative Wayland compositor [Sway](https://wiki.archlinux.org/title/Sway),
interestingly Kitty suddenly works under Sway:

    sudo pacman -S noto-fonts sway foot
    sway

Windows+Return opens [`foot`](https://codeberg.org/dnkl/foot) terminal,
Windows+Shift+e quits Sway; [this cheatsheet](https://wiki.garudalinux.org/en/sway-cheatsheet) has more.

**ToDo:** Customize Sway with correct keyboard, Kitty instead of Foot on Windows+Return,
a 24h instead of 12h clock, automatically opening browser and terminal, etc.
(Or just forget about Sway and only use Weston? If Kitty works!)

PS: Could also support Application Launchers via i3 syntax,
or (better) via standard freedesktop.org `.desktop` files,
e.g. using https://github.com/Biont/sway-launcher-desktop;
but who really needs that, anyways.


## Display Managers

**ToDo:** https://wiki.archlinux.org/title/Wayland#Display_managers,
but... what's the point, what does one really need that for? ;-)


## Videos

[VLC](https://wiki.archlinux.org/title/VLC_media_player) should let us watches videos:

    sudo pacman -S yt-dlp qt5-wayland vlc
    yt-dlp "https://www.youtube.com/watch?v=PUn4n-nGraM"
    vlc smurfs.mp4

But this doesn't quite work, until [audio is set-up](audio.md).


## Hardware Acceleration

**ToDo:** https://wiki.archlinux.org/title/Hardware_video_acceleration


## Modern Monitors

`dmesg -w -d -t -H -x` will typically show a lot of interesting `info` and `debug` (but should
not have any `err`) `pci*` and USB related messages when a modern (non-VGA) monitor is plugged in via a USB-C to USB-C,
or USB-C to HDMI, or USB-C to DisplayPort (but not HDMI to HDMI; not sure about DisplayPort to DisplayPort).

The following commands ([from here](https://gist.github.com/chrische/06d949d18af05765868ce7ca1855522a)) provide further details:

     sudo i2cdetect -l
     sudo i2cdetect 8

     ddcutil -h
     sudo ddcutil detect
     sudo ddcutil detect -v
     sudo ddcutil --bus 8 capabilities
     sudo ddcutil getvcp known --bus 8


## Hacking

**ToDo:** Hack a bunch of "hello, world" kind of graphical demos...

* Start with something drawing pixels on KMS?
* Then ideally initially only using just `libwayland-client`'s `wl_*` functions.
* Then with Cairo or OpenGL?
* Then subsequently use e.g. GTK as [GUI library](https://wiki.archlinux.org/title/Wayland#GUI_libraries)
