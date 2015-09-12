MPD
===

This package contains the configuration files for Music Player Daemon and sets
it up as required.

Files
=====

The files available in the package are::
  * mpdconf
  * mpd.desktop

mpdconf
-------

The `$HOME/.mpdconf` file sets the locations of the various files required by
MPD to store the music database. In addition, this file also configures MPD to
use ALSA as the output device.

mpd.desktop
-----------

The `$HOME/.config/autostart/mpd.desktop` file autostarts the MPD daemon as the
local user whenever a X11 instance starts.
