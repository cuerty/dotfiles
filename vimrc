scriptencoding utf-8

"
" qwerty's ~/.vimrc
"
"

" {{{ General settings
" The following are some sensible defaults for Vim for most users.
" We attempt to change as little as possible from Vim's defaults,
" deviating only where it makes sense
set nocompatible        " Use Vim defaults. (Much better!)
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
set textwidth=79

set viminfo='20,\"500   " Keep a .viminfo file.

" Don't use Ex mode, use Q for formatting.
map Q gq

" When doing tab completion, give the following files lower priority. You may
" wish to set 'wildignore' to completely ignore files, and 'wildmenu' to enable
" enhanced tab completion. These can be done in the user vimrc file.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out

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

if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on
  filetype indent on

  " Python
  let g:pyindent_open_paren = '4'
  let g:pyindent_nested_paren = '4'
  let g:pyindent_continue = '4'

  " Ruby
  au FileType ruby set softtabstop=2
  au FileType ruby set tabstop=2
  au FileType ruby set shiftwidth=2
  au FileType ruby set et

endif

au BufRead,BufNewFile *.py set ts=4 sts=4 sw=4 et
" au BufRead,BufNewFile *.py set textwidth=79
au BufRead,BufNewFile *.py set textwidth=240
au BufRead,BufNewFile *.py highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py match BadWhitespace /^\t\+/

au BufRead,BufNewFile *.c,*.cpp,*.h set ts=2 sts=2 sw=2 et
au BufRead,BufNewFile *.c,*.cpp,*.h set textwidth=78
au BufRead,BufNewFile *.c,*.cpp,*.h highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.c,*.cpp,*.h match BadWhitespace /^\t\+/

" }}}

" {{{ Look&feel settings
" Set colorscheme.
colorscheme desert

" Set font.
if !has("unix")
  set guifont=Lucida_Console:h10:cANSI
else
  " set guifont=Monospace\ 10
  set guifont=Monaco\ 12
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

" {{{ OmniCpp settings
" Behaive like a IDE that knows C++:
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone

let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
" }}}

" {{{ Tags settings
" Add the default tags for the common libraries and the one in the current
" directory:
set tags+=~/.tags/std3.3.tags
set tags+=~/.tags/poco-1.3.6p2-all.tags
set tags+=./tags
" }}}

" {{{ Session settings
" Store everything about a session:
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" }}}

" {{{ Mappings

" Map F8 to taglist.
nnoremap <silent> <F8> :Tlist<CR>
" Map Control-F12 to rebuild the tags file.
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" Map Control-q to save the current session.
map <C-q> :mksession! ~/.vim/.session <cr>
" Map Control-s to load the previus session.
map <C-s> :source ~/.vim/.session <cr>
" Map F2 to Nerdtree.
map <F2> :NERDTreeToggle<CR>

" }}}

" Probando si me conviene esto de resaltar despues de los 80 caracteres:
" Highlight rows longer than 80 characters
function ToggleOverLengthHi()
    if exists("b:overlengthhi") && b:overlengthhi
        highlight clear OverLength
        let b:overlengthhi = 0
        echo "overlength hilight off"
    else
        " adjust colors/styles as desired
        highlight OverLength ctermbg=darkred gui=undercurl guisp=blue
        " change '81' to be 1+(number of columns)
        match OverLength /\%81v.\+/
        let b:overlengthhi = 1
        echo "overlength hilight on"
    endif
endfunction
map <silent> <F1> <Esc>:call ToggleOverLengthHi()<CR>

" noremap  <Up> ""
" noremap! <Up> <Esc>
" noremap  <Down> ""
" noremap! <Down> <Esc>
" noremap  <Left> ""
" noremap! <Left> <Esc>
" noremap  <Right> ""
" noremap! <Right> <Esc>

" vim: set fenc=utf-8 tw=80 sw=2 ts=2 sts=2 et foldmethod=marker :
