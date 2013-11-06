"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         ViM Configuration File                              "
"                                                                             "
"  This file contains the various custom settings for the Vi IMproved editor  "
"                                                                             "
" (C)2013 Darshit Shah                                                        "
"                                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ensure that files are UTF-8 Encoded by default
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif


set nocompatible            " Use Vim defaults (much better!)
set bs=indent,eol,start     " Allow backspacing over everything in insert mode
set viminfo='20,\"50        " Read/write a .viminfo file, don't store more
                            " than 50 lines of registers
set history=50              " Keep 50 lines of command line history
set ruler                   " Show the cursor position all the time
set nu                      " Show Line Numbers
set autoindent              " Always set autoindenting on
set smartindent             " Set smart indenting
set expandtab               " Expand Tabs to Spaces
set shiftwidth=4            " Number of columns to move at each indent level
set softtabstop=4           " Number of columns moved on a <tab> key
set tabstop=4               " Number of columns a Tab represents
set smarttab                " Enable Smart tab'ing
set textwidth=80            " Auto wrap at char 80
set spell                   " Enable spell checking
set spelllang=en            " Define the default language of the document
set spellfile=$HOME/.vim/spell/en.utf-8.add
                            " Set a custom path for the spellfile
set showcmd                 " Show the command you are currently typing
set modeline                " Enable modeline support
set ttyfast                 " Improves Vim scrolling performance
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.~
                            " Ignore these files unconditionally
set wildmenu                " Use Wildcard expansion menu
set pastetoggle=<F2>        " Toggle paste mode with <F2>
