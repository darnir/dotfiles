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
