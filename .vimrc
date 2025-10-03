"basics
syntax on
filetype on
filetype plugin on
filetype indent on
set nocompatible
set nu rnu
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set history=1000
set number
set linebreak
"set mouse=a
"set paste

"leader key
let mapleader=","
nnoremap <leader>t :terminal<CR>

"KEY MAPPINGS
nmap l cl
xnoremap l cl
nmap s <Right>
xnoremap s <Right>
nnoremap <C-L> :nohl<CR><C-L>

"SPELL CHECK
set spell spelllang=en
set spellcapcheck=
hi SpellBad ctermbg=1

"LINE WRAP
set wrap
set wrapmargin=0
set textwidth=0
set breakindent
set breakindentopt=shift:2

"HIGHLIGHTS
set hlsearch
set showmatch
hi Search cterm=NONE ctermfg=black ctermbg=darkgreen
hi SpellBad cterm=NONE ctermfg=yellow ctermbg=darkred
hi MatchParen cterm=BOLD ctermfg=black ctermbg=darkgreen

" cursorline highlighting
set cursorline
hi CursorLine cterm=NONE ctermbg=22 ctermfg=15
hi CursorLineNr term=bold cterm=NONE ctermbg=22 ctermfg=15
" figure out keyboard shortcut for toggling cursorline

"custom highlighting
hi question ctermfg=darkblue
hi note ctermfg=darkgreen
hi reference ctermfg=yellow
hi warning ctermfg=darkred
augroup CustomHighlights
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * syntax match question  /.*??.*/
  autocmd VimEnter,WinEnter,BufWinEnter * syntax match note      /.*##.*/
  autocmd VimEnter,WinEnter,BufWinEnter * syntax match reference /.*<<.*/
  autocmd VimEnter,WinEnter,BufWinEnter * syntax match warning   /.*!!.*/
augroup END


"PLUGINS"
"rainbow parens conf 
let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['darkred', 'blue', 'darkgreen', 'magenta', 'yellow', 'grey'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold']
\}

"plugin management
call plug#begin('~/.vim/plugged')
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'jgdavey/tslime.vim'
"Plug 'preservim/nerdtree'
call plug#end()

"activate rainbow parens
let g:rainbow_active = 1

"tslime for piping selection to specified REPL for eval
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
let g:tslime_autoset_pane = 1
vmap <C-h><C-t> <Plug>SendSelectionToTmux
nmap <C-h><C-t> <Plug>NormalModeSendToTmux
nmap <C-h>r <Plug>SetTmuxVars

"nerdtree file hierarchy buffer
"nnoremap <leader>g :NERDTreeFocus<CR>
"nnoremap <leader>c :NERDTree<CR>
"nnoremap <leader>t :NERDTreeToggle<CR>
"nnoremap <leader>h :NERDTreeFind<CR>
"augroup nerdtree_sicp
"  autocmd!
"  autocmd BufWritePost * if exists("t:NERDTreeBufName") | execute 'NERDTreeFind' | execute 'NERDTreeRefreshRoot' | execute 'NERDTreeClose' | endif
"augroup END

"MISC
"racket specifics
augroup racket_specifics
  autocmd!
  autocmd FileType racket setlocal nocursorline
  autocmd filetype lisp,scheme,art,racket setlocal equalprg=scmindent.rkt
  "figure out disabling paren default paren highlighting for racket files
augroup END

"disable auto comment globally
augroup NoAutoComment
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

"open file with cursor at last location
augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
    \ let line = line("'\"")
    \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \      && !&diff
    \ |   execute "normal! g`\""
    \ | endif
augroup END
