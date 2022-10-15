# Linux Login

**ToDo:** Contribute (some of) this as e.g. https://wiki.archlinux.org/title/Login ?

**ToDo:** Better define, explain and illustrate (pseudo-?)`pty` and `tty`,
read e.g.  https://www.linusakesson.net/programming/tty/.


## Local Linux (Virtual) Console/s

Both Legacy BIOS or modern UEFI firmware have an API to a _"Console"._

The [Linux Kernel's console](https://en.wikipedia.org/wiki/Linux_console)
communicates with that firmware API to [read keyboard input](https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration) (`loadkeys`, `keyboard.c`),
and output characters to pixels (using `fbdev` [framebuffer](https://en.wikipedia.org/wiki/Linux_framebuffer), with fonts), or
([historically](https://wiki.archlinux.org/title/Linux_console#Text_mode))
to [text mode](https://en.wikipedia.org/wiki/Linux_console#Text_mode_console))

Systemd's `multi-user.target` (try `systemctl list-units --type=target` and
see [systemd targets](https://wiki.archlinux.org/title/Systemd#Targets)) launches, as
illustrated by `systemctl list-dependencies multi-user.target`, among many other useful things,
the `systemd-logind.service` and `getty.target` which starts `getty@tty1.service`.

[`systemd-logind`](https://www.freedesktop.org/software/systemd/man/systemd-logind.service.html)
(quote) _"spawns text logins (gettys) on virtual console activation"._
([D-Bus interface](https://www.freedesktop.org/software/systemd/man/org.freedesktop.login1.html))

This launches [`agetty`](https://man.archlinux.org/man/core/util-linux/agetty.8.en) which
invokes [`login`](https://man.archlinux.org/man/login.1), which is the binary that actually
prints the password prompts (or does PAM), authenticates, and then launches the user's shell;
try e.g. `systemctl status getty@tty1.service` to see it in action (after login on console).

See e.g. [Arch's `agetty` Getty doc](https://wiki.archlinux.org/title/Getty)
(or [`logind.c`](https://github.com/systemd/systemd/blob/main/src/login/logind.c)).

The Kernel not `systemd` or `agetty` or `login` manages
the [_virtual console_](https://en.wikipedia.org/wiki/Virtual_console)
where you can press Ctrl-Alt-F1 to Fx, and Alt-Right/Left keys to switch between _virtual terminals._

[`tty`](https://en.wikipedia.org/wiki/Tty_(Unix)) on a console will print e.g. `/dev/tty1`.
Login by SSH, look at the console, and from SSH try the following:

    sudo bash -c 'echo "Hi!" >/dev/tty0'

    sudo bash -c 'echo "Hi!" >/dev/vcs'

PS: Note how on a non-graphical system even though `systemctl get-default` is `graphical.target`,
until you install [graphics](graphics.md), `graphical.target` doesn't launch any `display-manager.service`.
So you could `systemctl isolate multi-user.target` or even `systemctl set-default multi-user.target`
and nothing would change.

PPS: Note how `sudo systemctl isolate rescue.target`
runs `systemd-login` which directly starts the root users's shell, without `login`.



## Local Graphical

**ToDo:** [graphics](graphics.md) etc.

https://01.org/linuxgraphics/gfx-docs/drm/driver-api/console.html


## SSH

`sshd` (`systemctl status sshd`) accepts incoming network connections, authenticates them and then,
[quote `man sshd`](https://man.archlinux.org/man/sshd.8#LOGIN_PROCESS), _"the client (then) either
requests an interactive shell or execution or a non-interactive command, which `sshd` will execute
via the user's shell using its -c option."_ (**ToDo:** What `-c` option?!)

[`tty`](https://en.wikipedia.org/wiki/Tty_(Unix)) on a SSH connection
will print e.g. `/dev/pts/0` - a [PTY pseudoterminal](https://en.wikipedia.org/wiki/Pseudoterminal)
device [devpts](https://en.wikipedia.org/wiki/Devpts).


## Serial

**ToDo:** Play with & document how to connect over USB serial,
particularly e.g. on some embedded devices; see also https://wiki.archlinux.org/title/Getty#Serial_console.


## Fingerprint

**ToDo:** https://wiki.archlinux.org/title/Fprint

