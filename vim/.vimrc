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
Plug 'mileszs/ack.vim'
Plug 'junegunn/goyo.vim'

"coding
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-rooter'
Plug 'sheerun/vim-polyglot'
Plug 'benmills/vimux'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'wellle/tmux-complete.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'

"python
"Plug davidhalter/jedi 
"Plug 'davidhalter/jedi-vim'
Plug 'julienr/vim-cellmode'

"Go
"Plug 'fatih/vim-go'                            " Go support
"Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' } " Go auto completion
"Plug 'zchee/deoplete-go', { 'do': 'make'}      " Go auto completion
"Plug 'sebdah/vim-delve'

"Javascript

"html

"misc
Plug 'godlygeek/tabular'

"themes
"Plug chriskempson/base16-vim
Plug 'w0ng/vim-hybrid'

call plug#end()

"----------------------------------------------
" General settings
"----------------------------------------------
"set python path separate from venvs
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

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
set statusline+=%(%{'help'!=&filetype?bufnr('%'):''}\ \|\ %)
set statusline+=%< " Where to truncate line
set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
set statusline+=\ %1*|
" Name of the current branch (needs fugitive.vim)
set statusline +=\ %{fugitive#statusline()}
" set statusline+=\ \|
" set statusline +=\ %{LinterStatus()}
set statusline+=\ %1*|
set statusline+=%= " Separation point between left and right aligned items.
set statusline+=\ %1*|
set statusline+=\ %{''!=#&filetype?&filetype:'-'}
set statusline+=%(\ \|%{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'')
  \.('unix'!=#&fileformat?'\ '.&fileformat:'')}%)
set statusline+=%(\ \|\ %{&modifiable?SleuthIndicator():''}%)
set statusline+=\ \|
set statusline +=%=%-14.(%l,%c%V%)\ %P

au InsertEnter * hi statusline ctermfg=lightblue guifg=lightgreen
au InsertChange * hi statusline ctermfg=lightgreen guifg=lightblue
au InsertLeave * hi statusline ctermfg=darkgreen guifg=#c5c8c6

"----------------------------------------------
" Plugin: prabirshrestha/asyncomplete
"----------------------------------------------
set showmode shortmess+=c
set completeopt-=preview
set completeopt+=longest,menu,menuone,noinsert
"
" <TAB>: completion.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

imap <c-space> <Plug>(asyncomplete_force_refresh)

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"let g:asyncomplete_remove_duplicates = 1

"let g:asyncomplete_smart_completion = 1
"let g:asyncomplete_auto_popup = 1

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

let g:tmuxcomplete#asyncomplete_source_options = {
            \ 'name':      'tmuxcomplete',
            \ 'whitelist': ['*'],
            \ 'config': {
            \     'splitmode':      'words',
            \     'filter_prefix':   1,
            \     'show_incomplete': 1,
            \     'sort_candidates': 0,
            \     'scrollback':      0,
            \     'truncate':        0
            \     }
            \ }

call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
			\ 'name': 'omni',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['c', 'cpp', 'html'],
			\ 'completor': function('asyncomplete#sources#omni#completor')
			\  }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

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
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn 

"----------------------------------------------
" Plugin: mileszs/ack.vim
"----------------------------------------------
" Open ack
nnoremap <leader>a :Ack!<space>

" ack/ag
if executable('ag')
    let g:ackprg = 'ag'
endif

"----------------------------------------------
" Plugin: ale
"----------------------------------------------
" ALE
" let g:ale_statusline_format = ['✖ %d', '⚠ %d', '⬥']
" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))

"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors

"     return l:counts.total == 0 ? 'OK' : printf(
"     \   '%dW %dE',
"     \   all_non_errors,
"     \   all_errors
"     \)
" endfunction
"----------------------------------------------
" Plugin: sebdah/vim-delve
"----------------------------------------------
" Set the Delve backend.
"let g:delve_backend = "native"

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
let g:rooter_patterns = ['.vimroot', '.git/', 'venv/', 'vendor/']

augroup vimrc_rooter
    autocmd VimEnter * :Rooter
augroup END


"----------------------------------------------
" Language: Golang
"----------------------------------------------
set autowrite
"autocmd BufRead $GOPATH/src/*.go
"        \ :GoGuruScope $GOPATH/src/maze/
"
"" Run goimports when running gofmt
"let g:go_fmt_command = "goimports"
"
"" Set neosnippet as snippet engine
""let g:go_snippet_engine = "neosnippet"
"
"" Enable syntax highlighting per default
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_extra_types = 1
"
"" Show the progress when running :GoCoverage
"let g:go_echo_command_info = 1
"
"" Show type information
"let g:go_auto_type_info = 1
"
"" Highlight variable uses
"let g:go_auto_sameids = 1
"
"" Fix for location list when vim-go is used together with Syntastic
"let g:go_list_type = "quickfix"
"
"" Add the failing test name to the output of :GoTest
"let g:go_test_show_name = 1
"
"" gometalinter configuration
"let g:go_metalinter_command = ""
"let g:go_metalinter_deadline = "5s"
"let g:go_metalinter_enabled = [
"			\ 'deadcode',
"			\ 'gas',
"			\ 'goconst',
"			\ 'gocyclo',
"			\ 'golint',
"			\ 'gosimple',
"			\ 'ineffassign',
"			\ 'vet',
"			\ 'vetshadow'
"			\]
"
"" Set whether the JSON tags should be snakecase or camelcase.
"let g:go_addtags_transform = "snakecase"
"
"" " neomake configuration for Go.
"" let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
"" let g:neomake_go_gometalinter_maker = {
"" 			\ 'args': [
"" 			\   '--tests',
"" 			\   '--enable-gc',
"" 			\   '--concurrency=3',
"" 			\   '--fast',
"" 			\   '-D', 'aligncheck',
"" 			\   '-D', 'dupl',
"" 			\   '-D', 'gocyclo',
"" 			\   '-D', 'gotype',
"" 			\   '-E', 'misspell',
"" 			\   '-E', 'unused',
"" 			\   '%:p:h',
"" 			\ ],
"" 			\ 'append_file': 0,
"" 			\ 'errorformat':
"" 			\   '%E%f:%l:%c:%trror: %m,' .
"" 			\   '%W%f:%l:%c:%tarning: %m,' .
"" 			\   '%E%f:%l::%trror: %m,' .
"" 			\   '%W%f:%l::%tarning: %m'
"" 			\ }
"
"" Mappings
"au FileType go nmap <F8> :GoMetaLinter<cr>
"au FileType go nmap <F9> :GoCoverageToggle -short<cr>
"au FileType go nmap <F10> :GoTest -short<cr>
"au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
"au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
"au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
"au FileType go nmap <leader>gt :GoDeclsDir<cr>
"au FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
"au FileType go nmap <leader>gd <Plug>(go-def)
"au FileType go nmap <leader>gdv <Plug>(go-def-vertical)
"au FileType go nmap <leader>gdh <Plug>(go-def-split)
"au FileType go nmap <leader>gD <Plug>(go-doc)
"au FileType go nmap <leader>gDv <Plug>(go-doc-vertical)
"
"au FileType go nmap <leader>r <Plug>(go-rename)
"" who just builds
"au FileType go nmap <leader>b <Plug>(go-run)  
"au FileType go nmap <leader>t <Plug>(go-test)
"au FileType go nmap <leader>c <Plug>(go-coverage)
"
"au FileType go nmap <Leader>ds <Plug>(go-def-split)
"au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
"au FileType go nmap <Leader>dt <Plug>(go-def-tab)
"
"
"au FileType go nmap <Leader>s <Plug>(go-implements)
"au FileType go nmap <Leader>e <Plug>(go-rename)

