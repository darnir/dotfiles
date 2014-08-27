Dotfiles Manager
================

`Dotfiles Manager` is a new way of managing all your dotfiles on a \*nix
system. The idea behind this project is to bundle together a set of files
which configure the settings for a particular aspect of the system as a
"Package". Creating such packages of dotfiles helps in maintaining them in the
long run.

This project works by creating a symlink for the file from the Package in the
repository to the location on the system where it needs to be. As a result, any
changes to the configuration files, AFTER the package has been installed will
automatically be reflected in the repository. Since this is a Git repository,
one can look at the diffs of the changes and revert back to the original state
very easily. Once, you have confirmed that the changes are good, they should be
committed to the repository.

Packaging
---------

We use the term "dotfile package" in this project. A dotfile package is a
collection of files which configure a particular aspect of the system. Hence,
one can have a package for Vim, Bash, SSH, X, etc. To make a new package,
create a directory with the package name in the root of the repository. This
directory should contain all the files which should be handled by the dotfile
manager. All the files and directories which should be handled by the dotfile
manager, should reside only in the top level of the package directory.
Next, one needs to write the install script for this package.

Install Scripts
---------------

An install script is a valid bash script which is executed to install a
particular package. An install script **must** define the `PACKAGE_NAME`
variable  at the very beginning. This variable is used to locate the
configuration file in the repository. Any file being marked for install is
expected in `$PACKAGE_NAME/` directory in the repository. The dotfiles manager
calls the following functions in the same order, if they are defined:

   1. **`prepare()`**: Used to perform initialization tasks before a package is
      installed. This is includes creating the directory structure, setting
      environment variables, etc.
   2. **`install()`**: This function is always called by the script and **must**
      always be defined. It is used for the actual installation of the files
      in the system.
   3. **`post_install()`**: Used to perform some post-installation tasks like
      setting the attributes of some file, or installing files not included in
      dotfiles.

Here, we use the word, "install" to imply the act of creating a symlink from the
file in the repository to the path on the system where the configuration file is
expected to exist. For example, to the `bashrc` file is generally expected to
exist in `~/.bashrc`, hence installing the file is equivalent to running the
command `$ ln -s $PWD/Bash/bashrc $HOME/.bashrc` from the root of the
repository. TO make things easier, the package manager provides some helper
functions that can be utilized for installing files and directories:

   * **`install_file()`**: Expects 4 parameters
      1. **File Name**: This is the exact name of the file as it exists in the
         package
      2. **Final Location**: The location where this file should be symlinked.
         It accepts full paths, up to the final directory but not the filename,
         or you can use one of the given shortcut paths:
           * *home*: Store in `$HOME` after adding a dot (.) prefix to the
             filename
           * *etc*: Store in `/etc`
           * *systemd-user*: Store in `$HOME/.config/systemd/user/ as a systemd`
             user session unit
           * *bin*: Store in `/usr/local/bin`
           * autostart: A X autostart file, store in `$HOME/.config/autostart`
      3. **Sudo**: Boolean value. Does the file need to be linked with root
         privileges?
      4. **Link Type**: What kind of a link should be made? This should always
         be true, which implies soft links. Only certain files, such as systemd
         units should be hard linked.
   * **`install_private_file()`**: This function is similar to
     `install_file()` except that it expects the file being symlinked to exist
     in `/media/truecrypt1/` instead of in the dotfiles package. This function
     is used to install files which contain sensitive information and hence are
     stored in a secure container instead of committing them to a public
     repository.
   * **`install_directory()`**: This function is used to install a complete
     directory as a symlink.

Usage
-----

The central entity in this project is the `dotfiles` script available in the
root directory of the repository. This script should be used to install / list
all available packages. At least currently, this script has been written purely
as a hack and hence it just works. A lot of the fail-safes required in a major
release haven't been incorporated yet. One of the chief limitations this poses
is that the script must always be called from the root directory of the dotfiles
since it leverages relative paths from there. This restriction will be removed
when someone submits a patch for it.

```
Usage: ./dotfiles [Options]
List of valid options:
-I package  : Install dotfiles package "package"
-l          : List available packages
-h          : Print this help and exit
Remember, this script must only be invoked from the root dir of the repository
```

Credits
=======

Author: Darshit Shah  <darnir@gmail.com>  
License: MIT

>  vim: set ts=2 sts=4 sw=2 tw=80 ft=markdown et :
