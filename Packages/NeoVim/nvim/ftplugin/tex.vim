let g:tex_flavor = "latex"
let g:tex_fold_enabled = 1
let g:vimtex_fold_enabled = 1
set conceallevel=2
let g:tex_comment_nospell = 1

let g:vimtex_compiler_enabled = 0
let g:vimtex_complete_enabled = 1

set tw=0


if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

map <F7> :VimtexTocToggle<CR>
