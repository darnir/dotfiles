" Required for vim-latexsuite to work correctly
" Please install vim-latex from either AUR or manually

set grepprg=grep\ -nH\ $*
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
set iskeyword+=:

let g:Tex_ViewRule_pdf = "evince"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
