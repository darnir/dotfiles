ViM
===

This package configures the compelte Vi IMproved setup in a system. The package
contains colorshemes, settings and a list of plugins that should be installed.

The installer script also sets up a plugin manager and installs all the plugins
mentioned. Hence, setting up ViM on a new system is as easy as calling the
ViM.sh installer script.

Files
=====

The following files are installed by the script:

  * **vimrc**: The `/etc/vimrc` and `$HOME/.vimrc` files contain all the
configuration information for a ViM setup. It contains various settings,
a list of plugins and other configurations. A list of currently used
plugins is also provided below.
  * **vim/**: The `$HOME/.vim/` directory is what contains the real crux of the
ViM settings. It contains the actual plugins, dictionary, format specific
settings, etc.

Plugins
=======

The various plugins being used in the current ViM setup are:

| Name                    | Description                         |
|-------------------------|-------------------------------------|
| tpope/vim-fugitive      | Excellent Git Wrapper               |
| godlygeek/tabular       | Beautify LaTeX Tables               |
| majutsushi/tagbar       | Browse source through Ctags         |
| plasticboy/vim-markdown | Better markdown Syntax highlighting |
| gerw/vim-latex-suite    | Full Latex Suite for Vim            |
| a.vim                   | Alternate between .c -> .h          |
| python.vim              | Better Python syntax highlighting   |
| dwm.vim                 | Very nice Buffer management for ViM |

