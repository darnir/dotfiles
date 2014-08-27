Darnir's Dotfiles
=================

This is a dotfiles repository that uses my custom `dotfiles mamager` scripts.
This repository contains a collection of various configuration files used to
customize my GNU/Linux based machines.. These files can be freely copied and
used by anybody who wishes to do so. I however take no responsibility for the
effects of doing so.

The files in repository are organized within a set of directories. Each
directory in the dotfiles root represents a package. Corresponding to each
package, is an `installscript` in the `InstallScripts/` directory. To install
any package, use the master `./dotfiles` script. Explanation on how to use the
script is available in the README_dotfiles.md file in repository.

Check the README.md file in each package for more information.

Files
=====
<pre>
.
├── ArchLinux
│   ├── makepkg.conf          -> /etc/makepkg.conf
│   └── pacman.conf           -> /etc/pacman.conf
├── Bash
│   ├── bash\_aliases         -> $HOME/.bash\_aliases
│   ├── bash\_profile         -> $HOME/.bash\_profile
│   ├── bashrc                -> $HOME/.bashrc
│   └── inputrc               -> $HOME/.inputrc
├── Compton
│   └── compton.conf          -> $HOME/.compton.conf
├── Conky
│   ├── conkyrc               -> $HOME/.conkyrc
│   ├── weather_update        -> /usr/local/bin/weather_update
│   ├── get_weather           -> /usr/local/bin/get_weather
│   ├── weather-update.service=> $HOME/.config/systemd/user/weather-update.service
│   └── weather-update.timer  => $HOME/.config/systemd/user/weather-update.timer
├── Git
│   ├── gitattributes         -> $HOME/.gitattributes
│   ├── gitconfig             -> $HOME/.gitconfig
│   └── gitk                  -> $HOME/.gitk
├── ViM
│   ├── vim                   -> $HOME/.vim/
│   ├── vimrc                 -> $HOME/.vimrc
│   └── vimshortcuts          -> N/a
├── SSH
│   ├── config                -> $HOME/.ssh/config
│   └── known\_hosts          -> $HOME/.ssh/known\_hosts
├── MPD
│   ├── mpdconf               -> $HOME/.mpdconf
│   └── mpd.desktop           -> $HOME/.config/autostart/mpd.desktop
├── Screen
│   └── screenrc              -> $HOME/.screenrc
├── X
│   └── xprofile              -> $HOME/.xprofile
└── Pentadactyl
    ├── pentadactylrc         -> $HOME/.pentadacylrc
    └── pentadactyl           -> $HOME/.pentadactyl/
</pre>

Suggested Order
===============

When using this dotfiles repository on a new installation, the following order
is suggested for the installation of the packages.

<pre>
1. ArchLinux
├── 2. Bash
├── 3. Git
│   └── 4. ViM
├── 5. SSH
├── 6. Screen
├── 7. MPD
├── 8. X
├── 9. Conky
├── 10. Pentadactyl
└── 11. Compton
</pre>

Each indentation level in the above diagram represents a dependency. Please
ensure you install all the dependencies *before* attempting to install a
package. `ArchLinux` should be installed only when setting up the dotfiles on an
Arch Linux system.

License
=======
MIT

Authors
=======
Darshit Shah  <darnir@gmail.com>

>  vim: set ts=2 sts=4 sw=2 tw=80 et :
