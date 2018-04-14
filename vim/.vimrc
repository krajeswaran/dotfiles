" General
set nocompatible        " must be first line
set background=dark     " Assume a dark background

set shell=/bin/bash  " posix complaint shell for os x 
" Plugins
call plug#begin('~/.vim/plugged')

"general
"Plug thesaneone/taskpaper.vim
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug vim-scripts/DirDo.vim
Plug 'Lokaltog/vim-easymotion'
"Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'mileszs/ack.vim'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

"coding
"Plug scrooloose/syntastic
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'lifepillar/vim-mucomplete'
" Plug 'ajh17/VimCompletesMe'
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
"Plug 'Shougo/neocomplete'
"Plug Shougo/neosnippet
"Plug Valloric/YouCompleteMe
"Plug majutsushi/tagbar
"Plug xolox/vim-easytags

"ruby
"Plug vim-ruby/vim-ruby
"Plug tpope/vim-rake
"Plug ecomba/vim-ruby-refactoring
"Plug astashov/vim-ruby-debugger

"python
"Plug klen/python-mode
"Plug davidhalter/jedi 
Plug 'davidhalter/jedi-vim'
"https:/hub.com/tmhedberg/SimpylFold
"https:/hub.com/vim-scripts/indentpython.vim

"Go
Plug 'fatih/vim-go'

"Javascript
"Plug leshill/vim-json
"Plug groenewege/vim-less
"Plug taxilian/vim-web-indent

"html
"Plug amirh/HTML-AutoCloseTag
"Plug ChrisYip/Better-CSS-Syntax-for-Vim
"Plug mattn/emmet-vim

"addl.syntaxes
"Plug tpope/vim-haml
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'

"misc
"Plug vim-scripts/Conque-Shell
"Plug mutewinter/LustyJuggler
"Plug fmoralesc/vim-pad
"Plug 'godlygeek/tabular'

"themes
"Plug altercation/vim-colors-solarized
"Plug chriskempson/base16-vim
Plug 'w0ng/vim-hybrid'

call plug#end()


" General
set mouse=v                 " automatically enable mouse usage
set go+=a
set splitbelow
set splitright
set showfulltag
set clipboard=unnamed
"set clipboard=unnamedplus
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
"au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
"au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

" Vim UI
"set tabpagemax=15               " only show 15 tabs
"set showmode                    " display the current mode

"autocmd FileType text setlocal textwidth=78
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

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

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

highlight BadWhitespace ctermbg=red guibg=darkred

" py tabs
" au BufNewFile,BufRead *.py 
"         \ set tabstop=4 |
"         \ set softtabstop=4 |
"         \ set shiftwidth=4 |
"         \ set textwidth=120 |
"         \ set expandtab |
"         \ set autoindent |
"         \ set fileformat=unix |

" " js tabs
" au BufNewFile,BufRead *.js,*.html,*.css
"         \ set tabstop=2 |
"         \ set softtabstop=2 |
"         \ set shiftwidth=2 |

" flag bad whitespace
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/


" Plugins 

" Notes
let g:notes_directories=['~/Google Drive/Notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'rename_file'
let g:notes_list_bullets = ['•', '◦', '▸', '▹', '▪', '▫']

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


" fzf
"let g:fzf_nvim_statusline = 0 " disable statusline overwriting

nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>p :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn 

" nnoremap <silent> <leader>gc :Commits<CR>
nnoremap <silent> <leader>gs :GFiles?<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWithAgInDirectory(...)
call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
let g:fzf_launcher = "xfce4-terminal -e \"bash -c %s\" -T'done'"

"" taskpaper
"   let g:task_paper_archive_file = 'Dropbox/todo/archive_todo.txt'
"

" singlecompile
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
let g:SingleCompile_showquickfixiferror = 1
let g:SingleCompile_showresultafterrun = 1


" python
" autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
let g:jedi#use_splits_not_buffers = "right"
autocmd BufNewFile,BufRead *.py let g:ackprg = 'ag --python'


" golang
set autowrite
autocmd BufNewFile,BufRead *.go let g:ackprg = 'ag --go'

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>s <Plug>(go-implements)

au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_excludes = ['gocyclo']
let g:go_guru_scope = ["..."]

" ack/ag
if executable('ag')
    let g:ackprg = 'ag'
endif

" Statusline (requires Powerline font, with highlight groups using Solarized theme)
set laststatus=2
set statusline=
set statusline+=%(%{'help'!=&filetype?bufnr('%'):''}\ \|\ %)
set statusline+=%< " Where to truncate line
set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
set statusline+=\ %1*|
" Name of the current branch (needs fugitive.vim)
set statusline +=\ %{fugitive#statusline()}
set statusline+=\ \|
set statusline +=\ %{ALEGetStatusLine()}
set statusline+=\ %1*|
set statusline+=%= " Separation point between left and right aligned items.
set statusline+=\ %1*|
set statusline+=\ %{''!=#&filetype?&filetype:'-'}
set statusline+=%(\ \|%{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'')
  \.('unix'!=#&fileformat?'\ '.&fileformat:'')}%)
set statusline+=%(\ \|\ %{&modifiable?SleuthIndicator():''}%)
set statusline+=\ \|
set statusline+=\ %2v " Virtual column number.
set statusline +=%=%-14.(%l,%c%V%)\ %P


" ALE
let g:ale_statusline_format = ['⨉  %d', '⚠ %d', '⬥ ']

" GUI Settings 
" GVIM- (here instead of .gvimrc)
set bg=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set lines=25
set guifont=Fira\ Code\ 12

" mucomplete
set showmode shortmess+=c
set completeopt-=preview
set completeopt+=longest,menu,menuone,noinsert
let g:jedi#popup_on_dot = 1  " It may be 1 as well
let g:mucomplete#enable_auto_at_startup = 0
