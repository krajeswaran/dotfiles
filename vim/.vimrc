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
call plug#begin('~/.vim/plugged')

"general
"Plug thesaneone/taskpaper.vim
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/goyo.vim'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'

"coding
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'lifepillar/vim-mucomplete'
Plug 'wellle/tmux-complete.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

"python
Plug 'julienr/vim-cellmode'

"Go
"Plug 'fatih/vim-go'                            " Go support

"Javascript

"html

"themes
Plug 'w0ng/vim-hybrid'

call plug#end()

"----------------------------------------------
" General settings
"----------------------------------------------
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

set grepformat=%f:%l:%m

set diffopt=filler,context:4,vertical
set makeprg=g++\ \\\--std=c++0x\ \\\\{$*}

" directories
set viewdir=$HOME/.vimview
set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimswap
"
" reopen last mark
autocmd BufReadPost * silent! normal! g`"zv

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
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
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

"----------------------------------------------
" Colors
"----------------------------------------------
set background=dark

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
    set guifont=Hack\ 11
    colorscheme hybrid
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

" ... but skip the quickfix when navigating
augroup qf
	autocmd!
	autocmd FileType qf set nobuflisted
augroup END

" Path
set path+=**

" netrw
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide = &wildignore
let g:netrw_list_hide+=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


" JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
"----------------------------------------------
" Status line
"----------------------------------------------
set laststatus=2
set statusline=
if has('gui_running')
	set statusline+=%#CursorColumn#
else
	set statusline+=%#Pmenu#
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
" set statusline+=\ %{fugitive#statusline()}
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}
" set statusline+=%#NonText#
set statusline+=%#Normal#
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

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

" tmux config
let g:tmuxcomplete#trigger = 'completefunc'

autocmd FileType markdown,text setlocal spell spelllang=en_us

imap <expr> <down> mucomplete#extend_fwd("\<down>")
let g:mucomplete#chains = {
			\ 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl', 'user'],
			\ 'markdown' : ['keyn', 'dict', 'uspl', 'user', 'path'],
			\ 'text' : ['keyn', 'dict', 'uspl', 'user', 'path'],
			\ 'python' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'ruby' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'javascript' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'java' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'html' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ 'css' : ['tags', 'path', 'omni', 'keyn', 'user'],
			\ }

"----------------------------------------------
" Plugin: gutentags
"----------------------------------------------
let g:gutentags_project_root = ['package.json', 'Readme.md', 'readme.md', 'README.md', '.root', '.git/', 'venv/', 'vendor/']

let g:gutentags_ctags_tagfile = '.tags'

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_auto_add_gtags_cscope = 0

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1


"----------------------------------------------
" Plugin: easymotion/vim-easymotion
"----------------------------------------------
" Enable support for bidirectional motions
map  <leader><leader>w <Plug>(easymotion-bd-w)
nmap <leader><leader>w <Plug>(easymotion-overwin-w)

"----------------------------------------------
" Plugin: 'junegunn/fzf.vim'
"----------------------------------------------
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>p :History<CR>
nnoremap <silent> <leader>/ :Ag<CR>


"----------------------------------------------
" Plugin: 'terryma/vim-multiple-cursors'
"----------------------------------------------
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_skip_key='<C-b>'

"----------------------------------------------
" Plugin: vim-rooter
"----------------------------------------------
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
let g:rooter_patterns = g:gutentags_project_root

augroup vimrc_rooter
    autocmd VimEnter * :Rooter
augroup END


