" Filetype detection for Perl files. Vim only recongnizes them by Shebang line
" without this.

au BufNewFile,BufRead *.px set filetype=perl
