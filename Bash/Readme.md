Bash
====

This package contains various files used for configuring Bash and readline.
The Readline library is often used by a lot of console applications, including
most shells. Hence, it is grouped along with Bash.

Files
=====

The files available in this repository are sourced in the following order:
  * inputrc
  * bash_profile
  * bashrc
  * bash_aliases

There are other shell initialization files which are currently not a part of
this dotfiles repository. Those will be loaded in their correct place in the
hierarchy.

inputrc
-------

The `/etc/inpurc` and `$HOME/.inputrc` files are used to configure Readline,
an input-related library for command line applications. These settings
influence most shells that are installed on the system. Do not put any shell-
specific settings in this file. `inputrc` is meant to only initialize the
Readline library.

bash_profile
------------

The `/etc/profile` and `$HOME/.bash_profile` files are initialization settings
for a Bash Login shell. Since bashrc is *only* loaded for *interactive* **and**
*non-login* shells, one should always load `bashrc` from the bash_profile as a
minimum.

bashrc
------

The general file for customizing the Bash Shell. This file contains various
settings, environment variables, PS{1,2,3} values, custom functions, etc.
It is loaded everytime a new shell starts.

bash_aliases
------------

This file is sourced from within `bashrc` and defines the different aliases
being used in the system. This file is kept separate to keep the `bashrc` file
clean from the large number of alises that are usually being set up.
