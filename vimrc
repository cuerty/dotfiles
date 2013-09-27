scriptencoding utf-8

"
" cuerty's ~/.vimrc
"
"

" {{{ General settings
" The following are some sensible defaults for Vim for most users.
" We attempt to change as little as possible from Vim's defaults,
" deviating only where it makes sense
set nocompatible        " Use Vim defaults. (Much better!)
filetype off
set bs=2                " Allow backspacing over everything in insert mode.
set ai                  " Always set auto-indenting on.
set history=50          " keep 50 lines of command history.
set ruler               " Show the cursor position all the time.
set showcmd             " Display incomplete commands.
set incsearch           " Do incremental searching.

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
" set number
set numberwidth=3
set textwidth=10000

set viminfo='20,\"500   " Keep a .viminfo file.

" Don't use Ex mode, use Q for formatting.
map Q gq

" When doing tab completion, give the following files lower priority. You may
" wish to set 'wildignore' to completely ignore files, and 'wildmenu' to enable
" enhanced tab completion. These can be done in the user vimrc file.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out

" }}}


" {{{ Vundle settings
" Install vundle:
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'msanders/snipmate.vim'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'vim-scripts/a.vim'

" }}}


" {{{ Modeline settings
" Enable modelines:
set modeline
" }}}

" {{{ Terminal fixes
if &term ==? "xterm"
  " Previously we would unset t_RV to prevent gnome-terminal from beeping as
  " vim started.  These days it appears that gnome-terminal has been repaired,
  " so re-enable this, and don't restrict t_Co=8.
  "set t_RV=      " don't check terminal version
  "set t_Co=8
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2 " only works for >=xfree86-3.3.3, should be okay
endif
" }}}

" {{{ Locale settings
" If we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
  set fileencodings^=ucs-bom
endif

" Always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
  set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
set fileencodings+=default
" }}}

" {{{ Syntax highlighting settings
" Switch syntax highlighting on also switch on highlighting the last used
" search pattern.
syntax on
set hlsearch
" }}}

" {{{ Filetype plugin settings
" Enable plugin-provided filetype settings, but only if the ftplugin
" directory exists.

filetype plugin indent on

au BufRead,BufNewFile *.py set ts=4 sts=4 sw=4 tw=0 et
au BufRead,BufNewFile *.py highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py match BadWhitespace /^\t\+/

" }}}

" {{{ Look&feel settings
" Set colorscheme.
colorscheme desert

" Set font.
if !has("unix")
  set guifont=Lucida_Console:h10:cANSI
else
  " set guifont=Monospace\ 10
  set guifont=Inconsolata\ 12
endif
" }}}

" {{{ Per OS settings
if !has("unix")
  set shell=cmd.exe
  set shellcmdflag=/c
  set noshellslash
endif
" }}}

" {{{ Number settings
set numberwidth=4
set number
" }}}

" {{{ Session settings
" Store everything about a session:
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" }}}

" {{{ Mappings
" Map F8 to taglist.
nnoremap <silent> <F8> :Tlist<CR>
" Map F2 to Nerdtree.
map <F2> :NERDTreeToggle<CR>
" EOL and BOL in insert mode.
imap <c-e> <c-o>$
imap <c-a> <c-o>^
" Let w!! save even if we don't have permissions over the file.
cmap w!! w !sudo tee % >/dev/null
" }}}

let $LANG='en'

" vim: set fenc=utf-8 tw=80 sw=2 ts=2 sts=2 et foldmethod=marker :
