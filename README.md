dotfiles
========

This repository contains a collection of various configuration files that are
used to customize my Arch Linux system. These files can be freely copied
and used by anybody who wishes to do so. I however take no responsibility for
the effects of doing so.

These files should ideally be symlinked to their respective locations. The
location for each file is provided below.

License
=======
GPLv3

Authors
=======
Darshit Shah  <darnir@gmail.com>

Files
=====
    * compton.conf      -> $HOME/.compton.conf
    * vimrc             -> $HOME/.vimrc
    * vim/              -> $HOME/.vim/
    * vim/latexsuite/\* -> /usr/share/vim/vimfiles/ftplugin/latex-suite/\*
    * gitconfig         -> $HOME/.gitconfig
    * gitattributes     -> $HOME/.gitattributes
    * gitk              -> $HOME/.gitk
    * bashrc            -> $HOME/.bashrc
    * makepkg.conf      -> /etc/makepkg.conf
    * pacman.conf       -> /etc/pacman.conf
    * mirrorlist        -> /etc/pacman.d/mirrorlist

Note
====
The vim/latexsuite path  must be manually symlinked. The symlink requires
superuser privileges and I prefer not to run scripts with sudo.

The gitconfig refers to an external application, git-merge-changelog. Remember
to install the same before using the configuration file. It is available on the
AUR as git-merge-changelog-git.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/darnir/dotfiles/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

