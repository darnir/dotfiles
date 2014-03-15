ArchLinux
=========

This package contains configuration files exclusively required by Arch Linux.

On any ArchLinux system, this is the first package that must be installed.

Files
=====

  * **pacman.conf**: This is the configuration file for ArchLinux's package
manager, pacman. It defines the various confguration settings and list of
repositories to sync with.
  * **pacman.d/mirrorlist**: This is a sorted version of the official mirrorlist
which lists the mirrors where the official repositories can be found.
  * **makepkg.conf**: This file states the various settings for makepkg, the
custom compiler script for ArchLinux packages. It sets CFLAGS, LDFLAGS,
MAKEFLAGS, etc.
