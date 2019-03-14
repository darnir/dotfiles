"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Neo-ViM Configuration File                          "
"                                                                             "
"  This file contains the various custom settings for Neo-ViM fork of Vim     "
"                                                                             "
"  Author: Darshit Shah <darnir [at] gmail [dot] com                          "
"                                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General Editor Settings {{{
set spellfile=$XDG_CONFIG_HOME/nvim/spell/en.utf-8.add
                                        " Set a custom Spell File
set modeline                            " Enable modeline support
let g:mapleader=','                     " Remap the leader key to something more convenient
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.~,*.aux,*.out,*.blg,*.lot,*.toc,*.pdf
                                        " Ignore these filetypes from within Vim
set lazyredraw                          " Delay redrawing window during macro
set clipboard=unnamedplus
                                        " Use the system clipboard as the default unnamed register
set gdefault                            " Always set the 'g' value when substitiuting
set hidden                              " Support hidden buffers
set switchbuf=useopen,usetab
                                        " Use existing open buffers and tabs to find file first
set wrapscan                            " Wrap searches around EOF
set directory=/tmp/                     " Temp. swap files need not persist
set runtimepath^=/usr/share/vim/vimfiles/
set exrc                                " Also load .exrc files from current directory
set secure                              " Don't run some insecure commands from local exrc files
set undofile                            " Create a persistent undo-file
set undodir=$XDG_CACHE_HOME/nvim/undo   " Location of these persistent undo files
" }}}

" Editor UI Settings {{{
set notermguicolors                     " Don't use True Colours for Terminal (256 is more than enough)
set ruler                               " Show the cursor position all the time
set showcmd                             " Show the command you are currently typing
set formatoptions+=tcroqnj
                                        " Set various options for formatting text.
                                        " Check |fo-options| for information
set scrolloff=6                         " Keep a buffer of 6 lines top and bottom when scrolling
set relativenumber                      " Show relative line numbers
set shortmess+=atIoOtT
                                        " Change the messages shown by vim
set foldmethod=syntax
set visualbell                          " Use a visual bell instead of a beep
set noerrorbells                        " Disable bells on errors
set noshowmode                          " Don't show the current editing mode
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:¬
set list
" }}}

" Indentation Settings {{{
set smartindent                         " Set smart indenting
set smarttab                            " Enable Smart tab'ing
set shiftwidth=4                        " Number of columns to move at each indent level
set softtabstop=4                       " Number of columns moved on a <tab> key
set tabstop=4                           " Number of columns a Tab represents
set textwidth=79                        " Auto wrap at char 80
" }}}

" Search Options {{{
set smartcase                           " Use smart case sensitivity when searching
set incsearch                           " Use incremental search
set magic                               " Use magic regex during searches
" This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR>i<CR><ESC>
" }}}

" Vim Plugin Management {{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'jacoborus/tender'                 " Use the tender colorscheme

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'bogado/file-line'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', {'for': 'toml' }
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': 'tex' }
Plug 'https://sanctum.geek.nz/code/vim-redact-pass.git'
Plug 'luochen1990/rainbow'

Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'

Plug 'vimwiki/vimwiki'

Plug 'w0rp/ale'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git', { 'for': 'git' }
call plug#end()
" }}}

" {{{ Set Colorscheme
" We must the colorscheme only AFTER Vundle has been loaded so that the
" relevant rtp has been set.

set background=dark
colorscheme tender	" Set the theme for Vim
"}}}

" Autocmd  Settings {{{

augroup filetype_settings
    autocmd!
    " Set spell checking only on files that make sense. Like TeX, mail and Markdown
    autocmd FileType tex,mail,markdown setlocal spell spelllang=en_us
    " autocmd FileType mail setlocal spell spelllang=en_us
    " autocmd FileType markdown setlocal spell spelllang=en_us
    autocmd FileType tex execute deoplete#enable()
augroup END

augroup cursor_positions
    autocmd!
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Tip: Place the cursor in the optimal position, editing email messages.
    " Author: Davide Alberani
    " Version: 0.1
    " Date: 24 May 2006
    " Description: if you use Vim to edit your emails, having to manually
    " move the cursor to the right position can be quite annoying.
    " This command will place the cursor (and enter insert mode)
    " in the more logical place: at the Subject header if it's
    " empty or at the first line of the body (also taking
    " care of the attribution, to handle replies messages).
    " Usage: I like to call the Fip command by setting the command that is used
    " by my mail reader (mutt) to execute Vim. E.g. in my muttrc I have:
    " set editor="vim -c ':Fip'"
    " Obviously you can prefer to call it using an autocmd:
    " " Modify according to your needs and put this in your vimrc:
    " au BufRead mutt* :Fip
    " Hints: read the comments in the code and modify it according to your needs.
    " Keywords: email, vim, edit, reply, attribution, subject, cursor, place.

    " Function used to identify where to place the cursor, editing an email.
    function FirstInPost (...) range
      let l:cur = a:firstline
      while l:cur <= a:lastline
        let l:str = getline(l:cur)
        " Found an _empty_ subject in the headers.
        " NOTE: you can put similar checks to handle other empty headers
        " like To, From, Newgroups, ...
        if l:str ==# 'Subject: '
          execute l:cur
          :start!
          break
        endif
        " We have reached the end of the headers.
        if l:str ==? ''
          let l:cur = l:cur + 1
          " If the first line of the body is an attribution, put
          " the cursor _after_ that line, otherwise the cursor is
          " leaved right after the headers (assuming we're writing
          " a new mail, and not editing a reply).
          " NOTE: modify the regexp to match your mail client's attribution!
          if strlen(matchstr(getline(l:cur), '^\* \w+ <\w+>.*')) > 0
            let l:cur = l:cur + 1
          endif
          execute l:cur
          :start
          break
        endif
        let l:cur = l:cur + 1
      endwhile
    endfunction

    " Command to be called.
    com Fip :set tw=0<Bar>:%call FirstInPost()

    au BufRead mutt* :Fip
augroup END

" Create non-existant directories
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let l:dir=fnamemodify(a:file, ':h')
        if !isdirectory(l:dir)
            call mkdir(l:dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" }}}

" {{{Ale Settings
let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'cpp': [],
\}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }}}

" Airline settings {{{
let g:airline_theme='tenderplus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline_detected_modified = 1
let g:airline_detect_iminsert = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_section_section_a = '%{gutentags#statusline()}'
let g:airline#extension#neomake#enabled = 1
" }}}

" {{{ NERD Settings
let g:NERDCreateDefaultMappings = 1
let g:NERDCompactSexyComs = 1
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
" }}}

"{{{ Tagbar Settings
let g:tagbar_autoclose=1
let g:tagbar_show_linenumbers=-1
"}}}

" CScope Settings {{{
source $XDG_CONFIG_HOME/nvim/cscope_maps.vim
" }}}

" Keyboard Shortcuts {{{
set pastetoggle=<F2>        " Toggle paste mode with <F2>
" Pressing <leader>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

map <F6> :NERDTreeToggle<CR>
map <F7> :TagbarToggle<CR>

nnoremap <leader>m :!make<Esc>

nnoremap <leader>o o<ESC>
nnoremap <leader>O O<Esc>

nnoremap <leader>w :set formatoptions+=a<CR>
nnoremap <leader>W :set formatoptions-=a<CR>

nnoremap <F5> :buffers<CR>:buffer<Space>

nnoremap s :%s/\s\+$//e
" }}}

" AppendModeline() {{{
" Append modeline after last line in buffer.  Use substitute() instead of
" printf() to handle '%%s' modeline in LaTeX files.
function! AppendModeline()
  let l:modeline = printf(' vim: set ts=%d sts=%d sw=%d tw=%d %set :',
        \ &tabstop, &softtabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
  call append(line('$'), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
" }}}

" cursor sniper {{{
set updatetime=2000

function! MySetCursor()
	set cursorline
	set cursorcolumn
endfunction
function! MyUnSetCursor()
	set nocursorline
	set nocursorcolumn
endfunction

augroup CursorSniper
	autocmd!
	au! CursorHold * call MyUnSetCursor()
	au! CursorMoved * call MySetCursor()
	au! CursorMovedI * call MyUnSetCursor()
augroup END
" }}}

" Highlight trailing whitespaces {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup highlight_whitespace
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END
" }}}

let g:rainbow_active=1
	let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

let g:vimwiki_list = [{'maxhi': 0, 'css_name': 'style.css', 'auto_export': 0, 'diary_index': 'diary', 'template_default': 'default', 'nested_syntaxes': {}, 'auto_toc': 1, 'auto_tags': 1, 'diary_sort': 'desc', 'path': '/home/thedoctor/.local/var/lib/vimwiki/wiki/', 'diary_link_fmt': '%Y-%m-%d', 'template_ext': '.tpl', 'syntax': 'default', 'custom_wiki2html': '', 'automatic_nested_syntaxes': 1, 'index': 'index', 'diary_header': 'Diary', 'ext': '.wiki', 'path_html': '/home/thedoctor/.local/var/lib/vimwiki/html/', 'temp': 0, 'template_path': '/home/thedoctor/.local/var/lib/vimwiki/templates/', 'list_margin': -1, 'diary_rel_path': 'diary/'}]

" vim: set ts=4 sts=4 sw=4 tw=80 fdm=marker et :
