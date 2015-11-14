# Dotfiles

This is a dotfiles repository to store the configuration files for my (Arch)
Linux system and other systems that I may be using. These files may be freely
copied for use by anybody.

The configuration files are grouped in the form of logical packages. Each
directory inside the `Packages/` directory represents a single, logical package.
Each package contains an `InstallScript` which defines where each file should be
placed. To install any package, use the master `dotfiles` script. Each package
usually also contains a small README file describing the contents of the
package.


## Dotfiles Manager

`Dotfiles Manager` is a way of managing all your dotfiles on a \*nix
system with ease. This project spawned from the simple idea of writing a couple
of scripts to automate the task of "installing" the configuration files to the
right locations on a new machine. It was later extended to use the concept of
packages to provide a finer granularity on which configuration files are
installed on a new system. Configuration files which should ideally all be
installed together, are grouped together as a single package.

When trying to keep a set of configuration files in a separate repository, it is
important that the repository be able to automatically track the changes to the
file. We should not have to remember to copy the file to the repository first.
Hence, the simplest way to accomplish this is to keep all the configuration
files in a single location which is tracked under a version control system. From
this location, the files are symlinked to the specific locations in the
filesystem where the relevant programs expect to find them. In this project, we
use Git as the version control system.

This project works by creating a symlink for the file from the Package in the
repository to the location on the system where it needs to be. As a result, any
changes to the configuration files, AFTER the package has been installed will
automatically be reflected in the repository. Since this is a Git repository,
one can look at the diffs of the changes and revert back to the original state
if need be. Upon confirming the changes are good, they should be immediately
committed to the repository.

A lot of the design decisions in this project are inspired from Arch Linux's
pacman and the format of the PKGBUILD files for defining a package.

### Packaging

A package is a collection of files which configure a particular aspect of the
system. Hence, one can have a package for Vim, Bash, SSH, X, etc. To create a
new package, simply create a new directory with the package name within the
`Packages/` directory and populate it with the files and directories that will
need to be tracked within this framework. Then write an `InstallScript` file
which contains the mappings for where each of the files in the packages should
be installed on the target system.

### InstallScripts

The concept of an `InstallScript` is based on ArchLinux's PKGBUILDs. An
`InstallScript` is a valid Bash script which is executed to install a particular
package. The script must implement the following variables:

  * **`PACKAGE_NAME`**: This is the name of the package being installed. It
    **must** contain the same name as that of the directory in which it resides.
    This variable is used to track Package Dependencies currently, though it may
    be used for other things in the future.

The master `dotfiles` script will invoke the following functions in the
specified order from the `InstallScript`. Only the `install()` function is
mandatory, the others may not be defined if there is no requirement.

   1. **`prepare()`**: Used to perform initialization tasks before a package is
      installed. This is includes installing dependencies, creating the
      directory structure, setting environment variables, etc.
   2. **`install()`**: This function is always called by the script and **must**
      always be defined. It is used for the actual installation of the files
      in the system.
   3. **`post_install()`**: Used to perform some post-installation tasks like
      setting the attributes of some file, or installing files not included in
      dotfiles.

Sometimes a package may be dependent on settings that are provided by another
packages. For example, a package may require using aliases or functions provided
by the Bash package. In such a case, it is useful to ensure that the required
package is installed first, before the current package is installed. For this,
the framework provides the `depends` function. Add the following line for each
package that must be installed before the current package at the top of the
`prepare()` function:

```
depends $REQUIRED_PKG_NAME
```

The concept of dependencies can also be used to create *meta packages*. A meta
package is one that installs no files of its own but instead a collection of
smaller packages in a single go. An example of such a meta package could be one
that installs the configuration packages for offlineimap, msmtp and mutt to
provide a functioning console based email client.

"Installing" a file is the act of creating a symlink from the
file in the repository to the path on the system where the configuration file is
expected to exist. For example, the `bashrc` file is generally expected to
exist at `~/.bashrc`, hence installing the file is equivalent to running the
command `$ ln -s $PWD/Packages/Bash/bashrc $HOME/.bashrc` from the root of the
repository. To make things easier, the package manager provides some helper
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
           * *userconf*: Store the file in the user's config directory. This is
             always `~/.config`
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
root directory of the repository. The script assumes that the user actually
knows what he/she is doing and as a result does not implement many sanity
checks. However, with a little bit of common, using this script shouldn't pose
any problems at all. One of the chief limitations of the script is that it
must always be called from the root directory of the repository
since it uses relative paths from there. Since I don't care much about this
restriction, I've decided not to work on it. However, if someone submits a
patch, I would not mind merging it.

```
Usage: ./dotfiles [Options]
List of valid options:
-S package  : Install dotfiles package "package"
-l          : List available packages
-h          : Print this help and exit
Remember, this script must only be invoked from the root dir of the repository
```

## TODO

  1. Before backing up a file, allow the user to immediately merge the two
  2. When installing a package, test if it has already been installed
  3. Do not re-install a dependency package if it has already been installed
  4. Before installing a file, try to figure out if the `ln` command will
     succeed. The most common failure is creating hard links across devices.
  5. Be smart and try to set the right sudo and linktype variables based on the
     filetype and path. E.g.: Files in /etc/ need sudo. Systemd units need to be
     hardlinked.
  6. Rework the concept of private files into private sub-packages that are
     stored in a non-public version control.
  7. Remove the requirement that `./dotfiles` be called from the root of the
     repository only.

## License
MIT

## Authors
Darshit Shah  <darnir@gmail.com>

>  vim: set ts=2 sts=4 sw=2 tw=80 et :
