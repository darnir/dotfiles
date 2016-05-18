" Required for vim-latexsuite to work correctly
" Please install vim-latex from either AUR or manually

set grepprg=grep\ -nH\ $*
set iskeyword+=:

nnoremap <F3> :TTemplate<CR>

let g:Tex_ViewRule_pdf = "evince"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:tex_comment_nospell = 1

" let g:syntastic_tex_checkers = ['lacheck']
