" ----------- General 

call plug#begin('~/.config/nvim/plugged')

"general
Plug 'tpope/vim-sensible'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree' ", { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'

"coding
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'mhinz/vim-grepper'
"Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'xuhdev/SingleCompile'
"Plug 'tpope/vim-commentary'
"Plug 'majutsushi/tagbar'
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'

"ruby
Plug 'vim-ruby/vim-ruby'
"Plug 'tpope/vim-rake'
"Plug 'ecomba/vim-ruby-refactoring'
"Plug 'astashov/vim-ruby-debugger'

"python
"Plug 'klen/python-mode'
"Plug 'davidhalter/jedi' 
"Plug 'davidhalter/jedi-vim'

"webdev
"Plug 'amirh/HTML-AutoCloseTag'
"Plug 'ChrisYip/Better-CSS-Syntax-for-Vim'
"Plug 'mattn/emmet-vim'
"Plug 'tpope/vim-haml'
"Plug 'groenewege/vim-less'
"Plug 'taxilian/vim-web-indent'
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'helino/vim-json'

"misc
"Plug 'vim-scripts/Conque-Shell'
"Plug 'mutewinter/LustyJuggler'
"Plug 'fmoralesc/vim-pad'
"Plug 'godlygeek/tabular'

"themes
"Plug 'altercation/vim-colors-solarized'
"Plug 'chriskempson/base16-vim'
Plug 'w0ng/vim-hybrid'

" go
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

call plug#end()

" ----------- GUI Settings 
set t_Co=256
let g:hybrid_use_Xresources = 1
colorscheme hybrid
"let g:base16colorspace=256
"colorscheme base16-colors
if has('gui_running')
    "colo my_murphy  
    set lines=30  "30 lines of text window size
    set guifont=Source\ Code\ Pro\ Semibold\ 8.5 
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
endif


" ----------- General Settings 
set background=dark
set mouse=a                 " automatically enable mouse usage
set go+=a
set splitbelow
set splitright
set showfulltag
set clipboard=unnamed
set clipboard=unnamedplus
scriptencoding utf-8

set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
"set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving
set backup                      " backups are nice ...
set lazyredraw                  " no unnecessary redraws
if has('persistent_undo')
    set undofile
    set undodir=~/.vimundo/
    set undolevels=1000         "maximum number of changes that can be undone
    set undoreload=10000        "maximum number lines to save for undo on a buffer reload
endif

set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l
"set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set winminheight=0              " windows can be 0 line high
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip  " MacOSX/Linux
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen

" ----------- Formatting 
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent
"set matchpairs+=<:>                " match, to be used with %
set paste                       " no indent on paste
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" Remove trailing whitespaces and ^M chars
"autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" shiftwidth for specific files
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" other niceties
set mousemodel=popup

set grepformat=%f:%l:%m

set diffopt=filler,context:4,vertical
"set makeprg=g++\ \\\--std=c++0x\ \\\\{$*}

" directories
set viewdir=$HOME/.vimviews
set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimswap

" ----------- Key (re)Mappings 

"The default leader is '\', but many people prefer ',' as it's in a standard
"location
let mapleader = ','

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
map <silent> <leader>n :cn<CR>zv
map <silent> <leader>p :cp<CR>zv

" ----------- NerdTree 
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:NERDShutUp=1
let b:match_ignorecase = 1
let g:NERDTreeMinimalUI = 1

" ----------- JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

" ----------- ctrlp
let g:ctrlp_working_path_mode = 2
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.swp$\|\.so$\|\.zip$' }
let g:updatetime=4000
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_by_filename = 1
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_open_new_file = 'h'


" ----------- singlecompile
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr>
let g:SingleCompile_showquickfixiferror = 1
let g:SingleCompile_showresultafterrun = 1

" ----------- syntastic
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ----------- lightline 
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'default',
            \ 'active': {
            \   'left': [ [ 'filename' ],
            \             [ 'readonly' ] ],
            \   'right': [ [ 'percent', 'lineinfo' ],
            \              [ 'fileencoding', 'filetype' ],
            \              [ 'fileformat', 'syntastic' ] ]
            \ },
            \ 'component_function': {
            \   'modified': 'WizMod',
            \   'readonly': 'WizRO',
            \   'filename': 'WizName',
            \   'filetype': 'WizType',
            \   'fileformat' : 'WizFormat',
            \   'fileencoding': 'WizEncoding',
            \   'mode': 'WizMode',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type': {
            \   'syntastic': 'error',
            \ },
            \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
            \ 'subseparator': { 'left': '▒', 'right': '░' }
            \ }

function! WizMod()
    return &ft =~ 'help\|vimfiler' ? '' : &modified ? '»' : &modifiable ? '' : ''
endfunction

function! WizRO()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'x' : ''
endfunction

function! WizName()
    return ('' != WizMod() ? WizMod() . ' ' : '') .
                \ ('' != expand('%:t') ? expand('%:t') : '[none]') 
endfunction

function! WizType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : '') : ''
endfunction

function! WizFormat()
    return ''
endfunction

function! WizEncoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction

" ----------- deoplete 
" Use deoplete.
let g:deoplete#enable_at_startup = 1

" disable autocomplete
let g:deoplete#disable_auto_complete = 0
if has("gui_running")
    inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
else
    inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
endif

" ------------ UltiSnips 
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" ----------- easyalign 
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ----------- vim-grepper 
" Mimic :grep and make ag the default tool.
let g:grepper = {
            \ 'tools': ['ag', 'git', 'grep'],
            \ 'open':  1,
            \ 'jump':  1,
            \ }

command! -nargs=* -complete=file Gg Grepper -tool git -query <args>
command! -nargs=* -complete=file Ag Grepper -tool ag  -query <args>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" ----------- deoplete-go
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" ----------- vim-go
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
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
let g:go_play_open_browser = 0

let g:go_term_enabled = 1
let g:go_term_mode = "split"

au FileType go nmap <leader>rt <Plug>(go-run-tab)
au FileType go nmap <Leader>rs <Plug>(go-run-split)
au FileType go nmap <Leader>rv <Plug>(go-run-vertical)

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

