"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Neo-ViM Configuration File                          "
"                                                                             "
"  This file contains the various custom settings for Neo-ViM fork of Vim     "
"																			  "
"  Author: Darshit Shah <darnir [at] gmail [dot] com                          "
"                                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" General Editor Settings {{{
" let NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
					" Set a custom Spell File
set modeline		" Enable modeline support
let g:mapleader=','	" Remap the leader key to something more convenient
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.~,*.aux,*.log,*.out,*.blg,*.lot,*.toc,*.pdf
					" Ignore these filetypes from within Vim
set lazyredraw		" Delay redrawing window during macro
set clipboard=unnamedplus
					" Use the system clipboard as the default unnamed register
set gdefault		" Always set the 'g' value when substitiuting
set hidden			" Support hidden buffers
set switchbuf=useopen,usetab
					" Use existing open buffers and tabs to find file first
set wrapscan		" Wrap searches around EOF
set directory=/tmp/	" Temp. swap files need not persist
set keywordprg=:Nman
" }}}

" Editor UI Settings {{{
set termguicolors	" Use True Colours for Terminal
set ruler			" Show the cursor position all the time
set showcmd			" Show the command you are currently typing
set formatoptions+=tcroqnj
					" Set various options for formatting text.
					" Check |fo-options| for information
set scrolloff=6		" Keep a buffer of 6 lines top and bottom when scrolling
set relativenumber	" Show relative line numbers
set shortmess+=atIoOtT
					" Change the messages shown by vim
set visualbell		" Use a visual bell instead of a beep
set noerrorbells	" Disable bells on errors
" }}}

" Indentation Settings {{{
set smartindent		" Set smart indenting
set smarttab		" Enable Smart tab'ing
set shiftwidth=4	" Number of columns to move at each indent level
set softtabstop=4	" Number of columns moved on a <tab> key
set tabstop=4		" Number of columns a Tab represents
set textwidth=79	" Auto wrap at char 80
" }}}

" Search Options {{{
set smartcase		" Use smart case sensitivity when searching
set incsearch		" Use incremental search
set magic			" Use magic regex during searches
"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR>i<CR><ESC>
" }}}

" {{{ Markdown-Composer
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction
" }}}

" Vim Plugin Management {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'xolox/vim-misc' | Plug 'xolox/vim-colorscheme-switcher', { 'on': 'NextColorScheme' }
Plug 'tpope/vim-vividchalk'
Plug 'flazz/vim-colorschemes', { 'on': 'NextColorScheme' }

" Plug 'kassio/neoterm'
" Plug 'mhinz/vim-grepper'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer'), 'for': 'markdown' }
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'bogado/file-line'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ludovicchabant/vim-gutentags'

Plug 'tpope/vim-liquid'
" Plug 'rust-lang/rust.vim'

Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
" Plug 'eapache/rainbow_parentheses.vim'

" Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'smancill/conky-syntax.vim', { 'for': 'conky' }
Plug 'Firef0x/PKGBUILD.vim', { 'for': 'PKGBUILD' }
Plug 'hrother/offlineimaprc.vim'
" Plug 'tmux-plugins/vim-tmux'
" Plug 'mgrabovsky/vim-xverif'

Plug 'a.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" Plug 'gerw/vim-latex-suite', { 'for': 'tex' }
" Plug 'gerw/vim-tex-syntax', { 'for': 'tex' }
Plug 'lervag/vimtex', { 'for': 'tex' }

" Plug 'nhooyr/neoman.vim'
call plug#end()
" }}}

" {{{ Set Colorscheme
" We must the colorscheme only AFTER Vundle has been loaded so that the
" relevant rtp has been set.

set background=dark
colorscheme vividchalk	" Set the theme for Vim
"}}}

" Autocmd  Settings {{{

augroup filetype_settings
    autocmd!
    " Set spell checking only on files that make sense. Like TeX, mail and Markdown
    autocmd FileType tex setlocal spell spelllang=en_us
    autocmd FileType mail setlocal spell spelllang=en_us
    autocmd FileType markdown setlocal spell spelllang=en_us
    " autocmd FileType markdown,tex,mail setlocal formatoptions+=a
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
        if l:str == 'Subject: '
          execute l:cur
          :start!
          break
        endif
        " We have reached the end of the headers.
        if l:str == ''
          let l:cur = l:cur + 1
          " If the first line of the body is an attribution, put
          " the cursor _after_ that line, otherwise the cursor is
          " leaved right after the headers (assuming we're writing
          " a new mail, and not editing a reply).
          " NOTE: modify the regexp to match your mail client's attribution!
          if strlen(matchstr(getline(l:cur), '^On.*wrote:.*')) > 0
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

" {{{ Neoterm Settings
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'

" Useful maps
" hide/close terminal
nnoremap <silent> <leader>th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> <leader>tc :call neoterm#kill()<cr>

" Git commands
command! -nargs=+ Tg :T git <args>
" }}}

" {{{ Neomake Settings
augroup NeomakeSettings
    autocmd!
    autocmd! BufWritePost * Neomake
    let g:neomake_python_enabled_makers = ['flake8']
    let g:neomake_python_flake8_maker = {
        \ 'args': ['--config=flake8.ini'],
        \ }
    let g:neomake_tex_enabled_makers = ['lacheck']
    let g:neomake_sh_enabled_makers = ['shellcheck']
    " let g:neomake_c_enabled_makers = ['gcc', 'clang-tidy']
augroup END
" }}}

" {{{ NeoSnippet Settings
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" " For conceal markers.
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif
" }}}

" {{{ Markdown Composer Settings
let g:markdown_composer_autostart=0
" }}}

" {{{ Vim-Grepper Settings
let g:grepper = {
    \ 'tools': ['git', 'grep'],
    \ 'open':  1,
    \ 'jump':  0,
    \ }
nnoremap <leader>git :Grepper -tool git -noswitch<cr>
nnoremap <leader># :Grepper -tool git -cword -noprompt<cr>
" }}}

" {{{ Easymotion Settings
" map <Leader> <Plug>(easymotion-prefix)
" }}}

" Airline settings {{{
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_detected_modified = 1
let g:airline_detect_iminsert = 0
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_section_section_a = '%{gutentags#statusline()}'
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

" " Rainbow Parentheses Settings {{{
" " TODO: FIX. Doesn't currently work
" let g:rbpt_colorpairs = [
"     \ ['red',         'RoyalBlue3'],
"     \ ['brown',       'SeaGreen3'],
"     \ ['blue',        'DarkOrchid3'],
"     \ ['gray',        'firebrick3'],
"     \ ['green',       'RoyalBlue3'],
"     \ ['magenta',     'SeaGreen3'],
"     \ ['cyan',        'DarkOrchid3'],
"     \ ['darkred',     'firebrick3'],
"     \ ['brown',       'RoyalBlue3'],
"     \ ['darkblue',    'DarkOrchid3'],
"     \ ['gray',        'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkmagenta', 'SeaGreen3'],
"     \ ['darkcyan',    'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]
" let g:rbpt_max = 16
" let g:rbpt_loadcmd_toggle = 0
" augroup rainbow_paren
"     autocmd!
"     au VimEnter * RainbowParenthesesActivate
"     au Syntax * RainbowParenthesesLoadRound
"     au Syntax * RainbowParenthesesLoadSquare
"     au Syntax * RainbowParenthesesLoadBraces
" augroup END
" " }}}

" CScope Settings {{{

source ~/.config/nvim/cscope_maps.vim

" }}}

" CTags Settings {{{
let g:ctags_statusline=1
let g:generate_tags=1
" C-\ will open in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
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

nnoremap <leader><leader> <Esc>
inoremap <leader><leader> <Esc>

nnoremap <leader>m :!make<Esc>

nnoremap <leader>r :RainbowParenthesesActivate<CR>
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

" DiffOrig() {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif
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

" vim: set ts=4 sts=4 sw=4 tw=80 fdm=marker et :
