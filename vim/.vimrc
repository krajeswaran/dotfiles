" General
set nocompatible        " must be first line

" Plugins
"----------------------------------------------
" Plugin management
"
" Download vim-plug from the URL below and follow the installation
" instructions:
" https://github.com/junegunn/vim-plug
"----------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"general
Plug 'krajeswaran/taskpaper.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'
Plug 'schickling/vim-bufonly'
Plug 'romainl/vim-cool'
Plug 'wincent/ferret'
Plug 'mg979/vim-visual-multi'
Plug 'mbbill/undotree'
Plug 'regedarek/ZoomWin'
Plug 'junegunn/goyo.vim'

"themes
"Plug 'arcticicestudio/nord-vim'
Plug 'w0ng/vim-hybrid'

"language tools
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'preservim/vim-pencil'
Plug 'rhysd/vim-grammarous'
Plug 'lifepillar/vim-mucomplete'
Plug 'previm/previm'

call plug#end()

"----------------------------------------------
" General settings
"----------------------------------------------
" Disable vim distribution plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_netrw = 1 
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_rrhelper = 1  " ?
let g:loaded_shada_plugin = 1  " ?
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

set mouse=v                 " automatically enable mouse usage
set go+=a
set splitbelow
set splitright
set showfulltag
set clipboard^=unnamed,unnamedplus
scriptencoding utf-8
set encoding=utf-8
"imap ^V ^O"+p
"set shellcmdflag=-ic
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')

" set title for terminal
set title

set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
"set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

" Setting up the directories
set backup                      " backups are nice ...
set lazyredraw                  " no unnecessary redraws
if has('persistent_undo')
	set undofile
	set undodir=~/.vimundo/
	set undolevels=1000         "maximum number of changes that can be undone
	set undoreload=10000        "maximum number lines to save for undo on a buffer reload
endif

" Enable mouse if possible
if has('mouse')
	set mouse=a
endif

" Allow vim to set a custom font or color for a word
syntax enable

set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,.git,.idea  " MacOSX/Linux
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=2                 " minimum lines to keep above and below cursor
"set foldenable                  " auto fold code
"set list
set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace


" Formatting
set formatoptions-=ro
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
"set matchpairs+=<:>                " match, to be used with %
set pastetoggle=<F2>                       " no indent on paste
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" other niceties
set mousemodel=popup

set diffopt=filler,context:4,vertical
set makeprg=g++\ \\\--std=c++0x\ \\\\{$*}

" directories
set viewdir=$HOME/.vimview
set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimswap
"
" reopen last mark
autocmd BufReadPost * silent! normal! g`"zv
autocmd BufRead todo.md set ft=taskpaper

" Key (re)Mappings

"The default leader is '\', but many people prefer ',' as it's in a standard
"location
let mapleader = "\<Space>"

" quick save
nnoremap <Leader>x :wq<CR>

" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :

" Easier moving in tabs and windows
map <C-S-Down> <C-W>j<C-W>_
map <C-S-Up> <C-W>k<C-W>_
map <C-S-Right> <C-W>l<C-W>_
map <C-S-Left> <C-W>h<C-W>_

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" The following two lines conflict with moving to top and bottom of the
" screen
" If you prefer that functionality, comment them out.
map <S-H> gT
map <S-L> gt

" Stupid shift key fixes
cmap WQ wq
cmap wQ wq
cmap Tabe tabe

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

""" Code folding options
set foldlevel=99
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Easier horizontal scrolling
map zl zL
map zh zH

"spell check
map <F7> :setlocal spell spelllang=en

"jump error list easily
map <silent> <leader>cn :cn<CR>zv
map <silent> <leader>cp :cp<CR>zv

"execute macros over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"better terminal mappings
" turn terminal to normal mode with escape
tnoremap <Esc> <C-W>N
" open terminal on ctrl+n
nnoremap <leader>t :term ++rows=10<CR>

"----------------------------------------------
" Colors
"----------------------------------------------
set background=dark

" if has('termguicolors')
"   set termguicolors " Use true colours
" endif

" fucking magenta autocomplete menu
highlight Pmenu ctermbg=darkgrey

" flag bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
highlight EndOfBuffer ctermbg=black ctermfg=black 

"----------------------------------------------
" GUI Settings 
"----------------------------------------------
" GVIM- (here instead of .gvimrc)
set bg=dark
if has('gui_running')
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    colorscheme hybrid
    set guifont=Hack\ Nerd\ Font\ Mono\ 12
    set lines=30
    highlight EndOfBuffer guifg=#1d1f21 guibg=#1d1f21
endif

"----------------------------------------------
" Searching
"----------------------------------------------
"set inccommand=split          " enables interactive search and replace

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"----------------------------------------------
" Navigation
"----------------------------------------------
" Disable arrow keys
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" Path
set path+=**

" JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
"----------------------------------------------
" Status line
"----------------------------------------------
set laststatus=2
function! GitStatus()
  return fugitive#head() != '' ? ' '.fugitive#head() : ''
endfunction

set statusline=
if has('gui_running')
  set statusline+=%#CursorColumn#
else
  set statusline+=%#NonText#
endif
set statusline+=\ %f
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
if has('gui_running')
  set statusline+=%#LineNr#
else
  set statusline+=%#PmenuSel#
endif
set statusline+=%=
set statusline+=%{'help'!=&filetype?bufnr('%'):''}
set statusline+=\ %{GitStatus()}
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}
if has('gui_running')
  set statusline+=%#NonText#
else
  set statusline+=%#PmenuSel#
endif
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

""----------------------------------------------
"" Plugin: vim-cool
""----------------------------------------------
let g:CoolTotalMatches = 1

"----------------------------------------------
" Plugin: fzf
"----------------------------------------------
nnoremap <unique> <leader>o  :History<CR>
nnoremap <unique> <leader>p  :Files<CR>
nnoremap <unique> <leader>/  :Rg <CR>

"----------------------------------------------
" Plugin: grammarous
"----------------------------------------------
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer>]d <Plug>(grammarous-move-to-next-error)
    nmap <buffer>[d <Plug>(grammarous-move-to-previous-error)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer>]d
    nunmap <buffer>[d
endfunction

"----------------------------------------------
" Plugin: previm/previm
"----------------------------------------------
let g:previm_open_cmd = 'xdg-open'

"----------------------------------------------
" Plugin: vim-bufonly
"----------------------------------------------
nmap <unique> <leader>q <cmd>:Bonly<CR>

"----------------------------------------------
" Plugin: lifepillar/vim-mucomplete
"----------------------------------------------
set showmode shortmess+=c
set belloff+=ctrlg
set completeopt-=preview
set complete-=t
set complete-=i
set completeopt+=menuone,noinsert,noselect

" turn omni func for all
set omnifunc=syntaxcomplete#Complete

set dictionary='/usr/share/dict/words'
autocmd FileType markdown,text setlocal complete+=k dictionary+=spell

imap <expr> <down> mucomplete#extend_fwd("\<down>")
let g:mucomplete#chains = {
			\ 'default' : ['file', 'c-n', 'path', 'omni', 'keyn', 'dict', 'uspl', 'user'],
			\ 'markdown' : ['file', 'c-n', 'omni', 'keyn', 'dict', 'uspl', 'user', 'path'],
			\ 'text' : ['file', 'c-n', 'omni', 'keyn', 'dict', 'uspl', 'user', 'path'],
			\ 'python' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'go' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'ruby' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'javascript' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'java' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'html' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'css' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ }

" for spelling in autocomplete
let g:mucomplete#can_complete = {}
let g:mucomplete#can_complete.default = {
        \     'c-n' : { t -> t =~# '\v\k{2,}$' },
        \     'uspl': { t -> t =~# '\v\k{3,}$' && &l:spell && !empty(&l:spelllang) },
        \ }
