Git
===

This package contains various configuration files required for setting up the
Git Version Control System. Apart from the configuration files which are
installed, the install script will also, **only for Arch Linux** download
and install other required files.

Files
=====

This package consists of 3 configuration files:

  * **gitk**: The `$HOME/.gitk` file configures how the inbuilt commit viewer,
gitk looks and behaves.
  * **gitconfig**: The `$HOME/.gitconfig` file has various customizations for
the overall look, feel and functioning of Git. It defines the committer name
and email id, along with different alises and various settings. **_Warning_**:
This file requires a newer version of Git. Installing this file on a system
with ancient versions of git *will* cause probelms. E.g. Debian Stable
  * **gitattributes**: The power-users Git customization file. This contains
more advanced customizations for Git, often used in conjunction with the
gitconfig file.

Git Merge Changelog
===================

GNU has a slightly different method of maintaining ChangeLogs for its programs.
These ChangeLogs often cause too much hassle when attempting to merge two
or more branches. For this reason, we use a custom diff driver for ChangeLog
files. This driver needs to be manually installed on the system. On ArchLinux
systems, the install script will automatically download and install the driver
the AUR. However, of you use some other distro, you need to manually download
and install the drivers. Else, just comment out the line.
