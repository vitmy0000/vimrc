"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

if !&diff
  Plug 'scrooloose/nerdtree'
  Plug 'unkiwii/vim-nerdtree-sync'
  Plug 'itchyny/lightline.vim'
  Plug 'taohex/lightline-buffer'
  Plug 'artnez/vim-rename'
  Plug 'szw/vim-maximizer'
  Plug 'jiangmiao/auto-pairs'
  Plug 'justinmk/vim-sneak'
  Plug 'lifepillar/vim-mucomplete'
  Plug 'machakann/vim-highlightedyank'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  " external tool dependent {{{...
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'majutsushi/tagbar'
  Plug 'mhinz/vim-signify'
  " }}}
endif
Plug 'morhetz/gruvbox'
Plug 'terryma/vim-smooth-scroll'
Plug 'haya14busa/incsearch.vim'

" Initialize plugin system
call plug#end()
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Better defaults {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic
set nocompatible
syntax on
filetype plugin indent on
" encoding
set encoding=utf-8
scriptencoding utf-8
" reload after external modification
set autoread
" cancel backup
set nobackup
" cancel swap file
set noswapfile
" enable mouse
set mouse=a
" save on buffer switch
set autowriteall
" spell check
set spell
" no bell
set belloff=all
" wildmenu
set wildmenu
set wildmode=list:longest,full
" timeout to send CursorHold
set updatetime=500
" stop auto comment inserting
augroup disable_auto_comment
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
" remove trailing space when saving buffer
augroup remove_trailing_space
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keys  {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" timeout
set timeout timeoutlen=3000 ttimeoutlen=30
augroup FastEscape
  autocmd!
  autocmd InsertEnter * set timeoutlen=10
  autocmd InsertLeave * set timeoutlen=3000
augroup END
" leader
let g:mapleader = "\<Space>"
" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
inoremap <buffer> <silent> <Up>=pumvisible() ? '\<UP>' : '<C-o>'gk
inoremap <buffer> <silent> <Down>=pumvisible() ? '\<Down>' : '<C-o>'gj
" stay visual mode after shifting
vnoremap < <gv
vnoremap > >gv
" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line,
" ` jumps to the marked line and column, so swap them
nnoremap ' `
nnoremap ` '
" y$ -> Y Make Y behave like other capitals
map Y y$
" help
nnoremap ? :vert help<Space>
cnoreabbrev vh vert help
" range search
vmap / <Esc>/\%V
" change window layout
cnoreabbrev wh windo wincmd H
cnoreabbrev wv windo wincmd K
" force write
cnoreabbrev fw w ! sudo tee %
" quick save, workaround for sneak spell bug
noremap s :set spell<CR>:write<CR>
noremap S :wa<CR>
" eol
set virtualedit=onemore
noremap $ $l
" quick leave
noremap Q :quit<CR>
" remap U to <C-r> for easier redo
nnoremap U <C-r>
" turn off search highlight
noremap <leader>/ :let @/=''<CR>:windo call clearmatches()<CR>
" use tab toggle fold
nnoremap <silent> <tab> @=(foldlevel('.')?'za':"\<tab>")<CR>
" star search for partial word
nnoremap * g*
nnoremap # g#
" buffer
nnoremap + :bn<CR>
nnoremap _ :bp<CR>
nnoremap - :bd<CR>
" emacs key mappings
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
cnoremap <C-e> <C-e>
cnoremap <C-a> <C-b>
set <M-f>=f
noremap! <M-f> <s-right>
set <M-b>=b
noremap! <M-b> <s-left>
" <M-BS> not available, <M-\> as a workaround
set <M-\>=
noremap! <M-\> <C-w>
noremap! <C-d> <Del>
noremap! <C-w> <C-w>
noremap! <C-u> <C-u>
" forward delete word and line are not feasible in command-line editing
" however, they are not very commonly used
set <M-d>=d
inoremap <M-d> <C-o>de
inoremap <C-k> <C-o>D
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show line number
set number
" use relative line number
set relativenumber
" show line and column number
set ruler
" show typing command in status line
set showcmd
" enable parentheses match
set showmatch
" scrolloff
set scrolloff=3
" highlight current line
set cursorline
" highlight column at 80
set colorcolumn=80
" invisible character
set listchars=tab:▸\ ,eol:¬,space:·
" theme
set background=dark
colorscheme gruvbox
" statusline
set laststatus=2
" fold
set foldopen-=search foldopen-=mark
set foldcolumn=1
set foldlevel=20
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent and search {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent
set autoindent
" change tab to space, enter Tab by Ctrl-V + Tab
set expandtab
set smarttab
set shiftround
" highlight search
set hlsearch
" incremental search
set incsearch
" case insensitive
set ignorecase
" case sensitive when uppercase letter appear
set smartcase
" <CR> inside parentheses
function! MyCR()
  if pumvisible()
    return "\<CR>"
  endif
  if col('.') < 2
    return "\<CR>"
  endif
  let l:prevChar = getline(line('.'))[col('.') - 2]
  let l:currChar = getline(line('.'))[col('.') - 1]
  if l:prevChar == '[' && l:currChar == ']'
    return "\<CR>\<BS>\<UP>\<C-o>\o"
  elseif l:prevChar == '{' && l:currChar == '}'
    return "\<CR>\<BS>\<UP>\<C-o>\o"
  endif
  return "\<CR>"
endfunction
" my simple indent settings {{{...
" indent one more after ( [ { : and indent back after )
filetype indent off
function GetMyIndent(lnum)
  " Search backwards for the previous non-empty line.
  " TODO: skip comment lines
  let l:plnum = prevnonblank(a:lnum - 1)
  if l:plnum == 0
    " This is the first non-empty line, use zero indent.
    return 0
  endif
  let l:pline = getline(l:plnum)
  " if previous line end up with ...
  if l:pline =~ '[[{:]\s*$'
    return indent(l:plnum) + &shiftwidth
  elseif l:pline =~ '(\s*$'
    if (&filetype == 'python')
      return indent(l:plnum) + &shiftwidth
    elseif (&filetype == 'cpp' || &filetype == 'java')
      return indent(l:plnum) + &shiftwidth + &shiftwidth
    endif
  endif
  return -1
endfunction
set indentkeys=o
set indentexpr=GetMyIndent(v:lnum)
" grep
highlight GrepHighlight ctermbg=Green ctermfg=Black
augroup grep_cmd
  autocmd!
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>:cclose<CR>:windo call clearmatches()<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> J :cn<CR>:copen<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> K :cp<CR>:copen<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> // :windo call matchadd("GrepHighlight", "<C-r>g")<CR>
  autocmd BufReadPost quickfix nnoremap <buffer> <leader>/ :windo call clearmatches()<CR>
  autocmd BufReadPost quickfix setlocal nocursorline
  autocmd BufReadPost quickfix :let g:quickfix_window_number = winnr()
augroup END
function! GrepOperator(type)
  if a:type ==# 'v'
    normal! `<v`>"gy
  elseif a:type ==# 'char'
    normal! `[v`]"gy
  else
    return
  endif
  mark G
  execute "silent grep -R --exclude-dir={.git,.hg} " . shellescape(@g) . " " . g:entry_dir
  copen
  execute "redraw!"
  execute "windo call matchadd(\"GrepHighlight\", " . shellescape(@g) . ")"
endfunction
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-- jiangmiao/auto-pairs -- {{{...
" disable multi-line jump close
let g:AutoPairsMultilineClose = 0
" turn on this may cause indent problem
let g:AutoPairsMapCR = 0
" allow <M-b> to work as word back move
let g:AutoPairsShortcutBackInsert = ''
" }}}

"-- tomtom/tcomment_vim -- {{{...
let g:tcommentMapLeaderOp1 = '<Leader>c'
let g:tcommentMapLeaderOp2 = '<Leader>C'
" }}}

"-- itchyny/lightline.vim -- {{{...
" get rid of the extraneous default vim mode
set hidden  " allow buffer switching without saving
set showtabline=2  " always show tabline
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', 'spell'],
  \             [ 'readonly', 'pwd'] ],
  \   'right': [ [ 'lineinfo', 'winnr' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ "inactive" : {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo', 'winnr' ],
  \              [ 'percent' ] ]
  \ },
  \ 'component': {
  \   'winnr': '%{"❐ " . winnr()}',
  \   'pwd': '%<%{LightlinePWD()}',
  \   'readonly': '%{&readonly?"\ue0a2":""}',
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \ 'tabline': {
  \   'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
  \   'right': [ [ 'close' ], ],
  \ },
  \ 'component_expand': {
  \   'buffercurrent': 'lightline#buffer#buffercurrent2',
  \ },
  \ 'component_type': {
  \   'buffercurrent': 'tabsel',
  \ },
  \ 'component_function': {
  \   'lineinfo': 'LightlineLineinfo',
  \   'percent': 'LightlinePercent',
  \   'spell': 'LightlineSpell',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \   'bufferbefore': 'lightline#buffer#bufferbefore',
  \   'bufferafter': 'lightline#buffer#bufferafter',
  \   'bufferinfo': 'lightline#buffer#bufferinfo',
  \ },
\ }
function! LightlinePWD()
  return "PWD: " . expand('%:p:h')
endfunction
function! LightlineSpell()
  return winwidth(0) > 70 ? (&spell ? 'SPELL' : '') : ''
endfunction
function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction
function! LightlinePercent()
  return winwidth(0) > 70 ? ((line(".") * 100) / line("$")) . '%' : ''
endfunction
function! LightlineLineinfo()
  return winwidth(0) > 70 ? (line(".") . ':' . col(".")) : ''
endfunction

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = '✭ '
let g:lightline_buffer_modified_icon = '+'
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = ' '

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20
" }}}

"-- terryma/vim-smooth-scroll -- {{{...
noremap <silent> K :call smooth_scroll#up(&scroll, 0, 1)<CR>
noremap <silent> J :call smooth_scroll#down(&scroll, 0, 1)<CR>
" }}}

"-- tpope/vim-surround -- {{{...
xmap s <Plug>VSurround
"}}}

"-- justinmk/vim-sneak -- {{{...
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" sneak#wrap(op, inputlen, reverse, inclusive, label)
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
nnoremap <silent> e :<C-U>call sneak#wrap('',           2, 0, 1, 1)<CR>
nnoremap <silent> E :<C-U>call sneak#wrap('',           2, 1, 1, 1)<CR>
xnoremap <silent> e :<C-U>call sneak#wrap(visualmode(), 2, 0, 1, 1)<CR>
xnoremap <silent> E :<C-U>call sneak#wrap(visualmode(), 2, 1, 1, 1)<CR>
onoremap <silent> e :<C-U>call sneak#wrap(v:operator,   2, 0, 1, 1)<CR>
onoremap <silent> E :<C-U>call sneak#wrap(v:operator,   2, 1, 1, 1)<CR>
" }}}

"-- machakann/vim-highlightedyank -- {{{...
hi HighlightedyankRegion ctermfg=Black ctermbg=Blue
map y <Plug>(highlightedyank)
" }}}

"-- szw/vim-maximizer -- {{{...
nnoremap <silent> <leader><space> :MaximizerToggle<CR>
nnoremap <silent> <leader>w <C-w>o
" }}}

"-- lifepillar/vim-mucomplete -- {{{...
set shortmess+=c
set complete-=t "no tag
set completeopt=menuone,noinsert
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
  \ 'default' : ['path', 'keyn'],
\ }
inoremap <expr> <cr> pumvisible() ? mucomplete#popup_exit("\<cr>") : MyCR()
" }}}

"-- haya14busa/incsearch.vim -- {{{...
hi Search ctermfg=Yellow ctermbg=Black
map /  <Plug>(incsearch-forward)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}

"-- scrooloose/nerdtree -- {{{...
map <leader>e :NERDTreeToggle<CR>
augroup nerdtree
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
  autocmd VimEnter * let g:entry_dir = getcwd()
  autocmd BufEnter * silent! lcd %:p:h
augroup END
"}}}

"-- mhinz/vim-signify -- {{{...
let g:signify_sign_show_count = 0
let g:signify_sign_change = '*'
" }}}

"-- majutsushi/tagbar -- {{{...
map <leader>t :TagbarToggle<CR>
" }}}

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lang {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2 shiftwidth=2 softtabstop=2
set foldmethod=indent

" vim
augroup file_vim
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" python
augroup file_py
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType python setlocal foldmethod=indent
augroup END

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extra functionality {{{...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change cursor type based on mode {{{...
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" }}}

" auto set paste {{{...
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
  let l:tmux_start = "\<Esc>Ptmux;"
  let l:tmux_end = "\<Esc>\\"
  return l:tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . l:tmux_end
endfunction
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ''
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" }}}

" jump to last postion when reopen {{{...
augroup last_position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
" }}}

" interactive jump {{{...
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
nmap <leader>o :call GotoJump()<CR>
" }}}

" interactive registers {{{...
function! MyRegPaste()
  registers
  let j = input("Please select your register: ")
  if j != ''
    execute "normal \"" . j . "p"
  endif
endfunction
nmap <leader>p :call MyRegPaste()<CR>
" }}}

" auto close quickfix window {{{...
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END
" }}}

" visual star search {{{...
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
" }}}

" }}}
