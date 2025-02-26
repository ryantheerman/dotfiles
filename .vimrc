syntax on
filetype on
filetype plugin on
filetype indent on
set nocompatible
set nu rnu
set shiftwidth=4
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

"KEY MAPPINGS"
nmap l cl
xnoremap l cl
nmap s <Right>
xnoremap s <Right>
nnoremap <C-L> :nohl<CR><C-L>

"SPELL CHECK"
set spell spelllang=en
set spellcapcheck=
hi SpellBad ctermbg=1

"LINE WRAP"
set wrap
set wrapmargin=0
set textwidth=0
set breakindent
set breakindentopt=shift:2

"HIGHLIGHTS"
set hlsearch
set showmatch
hi Search cterm=NONE ctermfg=black ctermbg=darkgreen
hi SpellBad cterm=NONE ctermfg=yellow ctermbg=darkred
hi MatchParen cterm=BOLD ctermfg=black ctermbg=darkgreen
hi question ctermbg=darkgreen ctermfg=black
syntax match question /.*??.*/
hi note ctermbg=darkblue ctermfg=black
syntax match note /.*@@.*/
hi reference ctermbg=yellow ctermfg=black
syntax match reference /.*''.*/
hi warning ctermbg=darkred ctermfg=black
syntax match warning /.*!!.*/
hi leadingWhitespaces ctermbg=black
syntax match leadingWhitespaces /^\s\s*/
