SSH
===

This package contains the files required for setting up the local SSH keys.
Prior to installing this package, the $HOME/.ssh/ directory should be symlinked
and contain the private keys in them. This package only contains the config
files for linking provate keys to respective servers and a list of known hosts
with verified public keys.

Files
=====

The files available in this repository are sourced in the following order:
  * config
  * known_hosts

config
------

The `$HOME/.ssh/config` file contains settings that configure various settings
like the username and the private key to be used for various hosts to which we
connect.

known_hosts
-----------

The `$HOME/.ssh/known_hosts` contains a list of hosts to which we connect. Each
line in the file contains the hostname, the encryption used and the public key
of the host.
