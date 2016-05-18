" Filetype detection of Python files.
" XXX: Detect Python2 and Python3 files separately?

au BufNewFile,BufRead *.py set filetype=python
