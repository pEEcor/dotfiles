# General Configuration
This contains all packages and configurations, applied after the general installation.

## Trizen
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
Grab [Hack](https://github.com/source-foundry/Hack) and [Fira Code](https://github.com/tonsky/FiraCode). Place fonts into `~/.local/share/fonts`.
```bash
# run
fc-cache -f -v
```

## Shell (fish)
```bash
# install fish
pacman -S fish

# install oh-my-fish
curl -L https://get.oh-my.fish | fish
```

## Firefox
```bash
# install firefox
pacman -S firefox

# enable wayland: add the following to /etc/environment
MOZ_ENABLE_WAYLAND=1
```

## Sound

To be able to nicely manage multiple input and output streams install `pulseaudio` `pulseaudio-alsa` and `pavucontrol`. Pavucontrol  is a GTK interface for pulseaudio. (As a side note, my G930 wireless headset didn't work with every USB3 port out of the box which was driving me nuts, a USB2 port solved it)
```bash
pacman -S pulseaudio pulseaudio-alsa pavucontrol
```

### Shell enhancements
This section assumes that the z shell is already your default shell.

#### Oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```


## Vim
This section holds all the packages which are necessary for my `.vimrc` to properly work. I'm using [pathogen](https://github.com/tpope/vim-pathogen) to organize my packages, it will start all packages dropped into `~/.vim/bundle`.
* [Solarized Colorscheme](https://github.com/altercation/vim-colors-solarized)
* [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
* [Airline](https://github.com/vim-airline/vim-airline)
* [Airline themes](https://github.com/vim-airline/vim-airline-themes)
* [Fugitive](https://github.com/tpope/vim-fugitive)
* [Sensible](https://github.com/tpope/vim-sensible)
* [Gitgutter](https://github.com/airblade/vim-gitgutter)
