# General Configuration

This contains all packages and configurations, applied after the general installation.

## yay

Install a tool to access the AUR.

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## dotfiles

Instructions for dotfiles stored inside a git repository:
[How to store dotfiles in git](https://www.atlassian.com/git/tutorials/dotfiles).

## Sway, Display Manager

```bash
# install favorite terminal emulator to have a terminal ready
pacman -S alacritty

# install sway
pacman -S sway

# Additionally fetch other sway components
pacman -S waybar swaylock swayidle
```

```bash
# install Ly display manger
trizen -S ly-git
# it can then be configured in /etc/ly/config.ini, the sway session will be detected automatically
```

## Fonts

Grab Nerd fonts patched version of Fira Code from AUR.

```bash
# run
yay -S nerd-fonts-fira-code
```

## Shell (ZSH)

Get the Z-shell, make it the default shell and grab oh-my-zsh.

```bash
# Grap z shell
pacman -S zsh
# Make it the default shell
usermod --shell /bin/zsh username
# Grap oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## greetd

Greetd is a greeter deamon. It is used to manage the login process and
automatically lauch a wayland compositor. In this case sway. It is also used to
set various environ variables to tighten the awareness of wayland beeing used.

```bash
# install greetd (deamon) and wlgreet (graphical frontend)
yay -S greetd wlgreet
```

Create `/usr/local/bin/sway-run.sh` with the following content and make it
executable.

```bash
#!/bin/sh

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

# source wayland environment variables
source /usr/local/bin/wayland_enablement.sh

# this redirects sway output to system journal
systemd-cat --identifier=sway sway $@
```

Create `/usr/local/bin/wayland_enablement.sh` with the following content and
make it executable.

```bash
#!/bin/sh
export MOZ_ENABLE_WAYLAND=1
export CLUTTER_BACKEND=wayland
export QT_QPA_PLATFORM=wayland-egl
export ECORE_EVAS_ENGINE=wayland-egl
export ELM_ENGINE=wayland_egl
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1
```

Establish a graphical greeter, wlgreet in this case. there is also gtkgreet.
wl-greet requires a running compositor, we use sway with the following custom
config in `/etc/greetd/sway-config`

```bash
exec "wlgreet --command sway-run.sh; swaymsg exit"

bindsym Mod4+shift+e exec swaynag \
-t warning \
-m 'What do you want to do?' \
-b 'Poweroff' 'systemctl poweroff' \
-b 'Reboot' 'systemctl reboot'

include /etc/sway/config.d/*
```

Tell greetd to execute our custom sway runner by modifying `/etc/greetd/config.toml`.

```bash
# customize /etc/greetd/config.toml
command = "sway --config /etc/greetd/sway-config"
```

And finally enable its service.

```bash
systemctl enable greetd.service
```

## Firefox

```bash
# install firefox
pacman -S firefox

# enable wayland: add the following to /etc/environment. This might be useful,
# greetd and its wayland setup is not yet completed.
MOZ_ENABLE_WAYLAND=1
```

## Sound

To be able to nicely manage multiple input and output streams install
`pulseaudio` `pulseaudio-alsa` and `pavucontrol`. Pavucontrol  is a GTK
interface for pulseaudio. (As a side note, my G930 wireless headset didn't work
with every USB3 port out of the box which was driving me nuts, a USB2 port
solved it)

```bash
pacman -S pulseaudio pulseaudio-alsa pavucontrol
```

## Other packages

### Official

```bash
wl-clipboard
```

### AUR

```bash
clipman
zsh-autosuggestions
zsh-syntax-highlighting
```
