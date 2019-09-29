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
Plug 'julienr/vim-cellmode', {'for': ['python', 'shell', 'ruby', 'javascript']}

"Go
"Plug 'fatih/vim-go'                            " Go support

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

" grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat="%f:%l:%c:%m"
fun! s:RgSearch(txt)
  silent! exe 'grep! ' . a:txt
  if len(getqflist())
    exe 'copen'
    redraw!
  else
    cclose
    redraw!
    echo "No match found for " . a:txt
  endif
endfun
command! -nargs=1 -complete=tag RgSearch :call s:RgSearch(<q-args>)

nnoremap <unique> <Leader>f :RgSearch<Space>

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
" Plugin: srstevenson/vim-picker, copied/modded
"----------------------------------------------
let g:picker_selector_executable = 'fzy'
let g:picker_split = 'botright'
let g:picker_height = 10

function! ListFilesCommand() abort
    " Return a shell command suitable for listing the files in the
    " current directory, based on whether the user has specified a
    " custom find tool, and if not, whether the current directory is a
    " Git repository and if fd is installed.
    "
    " Returns
    " -------
    " String
    "     Shell command to list files in the current directory.
    if executable('fd')
        return 'fd --color never --type f'
    else
        return 'find . -type f'
    endif
endfunction

function! ListBuffersCommand() abort
    " Return a shell command which will list current listed buffers.
    "
    " Returns
    " -------
    " String
    "     Shell command to list current listed buffers.
    let l:bufnrs = range(1, bufnr('$'))

    " Filter out buffers which do not exist or are not listed, and the
    " current buffer.
    let l:bufnrs = filter(l:bufnrs, 'buflisted(v:val) && v:val != bufnr("%")')

    let l:bufnames = map(l:bufnrs, 'bufname(v:val)')
	let l:oldfiles = filter(map(copy(v:oldfiles), 'expand(v:val)'), 'filereadable(v:val)')

    return 'echo "' . join(l:bufnames + l:oldfiles, "\n"). '"'
endfunction

function! ListTagsCommand() abort
    " Return a shell command which will list known tags.
    "
    " Returns
    " -------
    " String
    "     Shell command to list known tags.
    return 'grep -vh "^!_TAG_" ' . join(tagfiles()) . ' | cut -f 1 | sort -u'
endfunction

function! s:PickerTermopen(list_command, callback) abort
    " Open a Neovim terminal emulator buffer in a new window using termopen,
    " execute list_command piping its output to the fuzzy selector, and call
    " callback.on_select with the item selected by the user as the first
    " argument.
    "
    " Parameters
    " ----------
    " list_command : String
    "     Shell command to generate list user will choose from.
    " callback.on_select : String -> Void
    "     Function executed with the item selected by the user as the
    "     first argument.
    let l:callback = {
                \ 'window_id': win_getid(),
                \ 'filename': tempname(),
                \ 'callback': a:callback
                \ }

    let l:directory = getcwd()
    if has_key(a:callback, 'cwd') && isdirectory(a:callback.cwd)
        let l:callback['cwd'] = a:callback.cwd
        let l:directory = a:callback.cwd
    endif

    function! l:callback.on_exit(job_id, data, event) abort
		" Close the current window, deleting buffers that are no longer displayed.
		set bufhidden=delete
		close!
        call win_gotoid(l:self.window_id)
        if filereadable(l:self.filename)
            try
                call l:self.callback.on_select(readfile(l:self.filename)[0])
            catch /E684/
            endtry
            call delete(l:self.filename)
        endif
    endfunction

    execute g:picker_split g:picker_height . 'new'
    let l:term_command = a:list_command . '|' . g:picker_selector_executable .
                \ ' ' . '--lines=10' . '>' . l:callback.filename
    let s:picker_job_id = termopen(l:term_command, l:callback)
    let b:picker_statusline = 'Pick [pwd: ' . l:directory . ']'
    setlocal nonumber norelativenumber statusline=%{b:picker_statusline}
    setfiletype picker
    startinsert
endfunction

function! s:PickerTermStart(list_command, callback) abort
    " Open a Vim terminal emulator buffer in a new window using term_start,
    " execute list_command piping its output to the fuzzy selector, and call
    " callback.on_select with the item selected by the user as the first
    " argument.
    "
    " Parameters
    " ----------
    " list_command : String
    "     Shell command to generate list user will choose from.
    " callback.on_select : String -> Void
    "     Function executed with the item selected by the user as the
    "     first argument.
    let l:callback = {
                \ 'window_id': win_getid(),
                \ 'filename': tempname(),
                \ 'callback': a:callback
                \ }

    let l:directory = getcwd()
    if has_key(a:callback, 'cwd') && isdirectory(a:callback.cwd)
        let l:callback['cwd'] = a:callback.cwd
        let l:directory = a:callback.cwd
    endif

    function! l:callback.exit_cb(...) abort
        close!
        call win_gotoid(l:self.window_id)
        if filereadable(l:self.filename)
            try
                call l:self.callback.on_select(readfile(l:self.filename)[0])
            catch /E684/
            endtry
            call delete(l:self.filename)
        endif
    endfunction

    let l:options = {
                \ 'curwin': 1,
                \ 'exit_cb': l:callback.exit_cb,
                \ }

    if strlen(l:directory)
        let l:options.cwd = l:directory
    endif

    execute g:picker_split g:picker_height . 'new'
    let l:term_command = a:list_command . '|' . g:picker_selector_executable .
                \ ' ' . '--lines=10' . '>' . l:callback.filename
    let s:picker_buf_num = term_start([&shell, &shellcmdflag, l:term_command],
                \ l:options)
    let b:picker_statusline = 'Pick [pwd: ' . l:directory . ']'
    setlocal nonumber norelativenumber statusline=%{b:picker_statusline}
    setfiletype picker
    startinsert
endfunction


function! s:Picker(list_command, callback) abort
    " Invoke callback.on_select on the line of output of list_command
    " selected by the user, using PickerTermopen() in Neovim and
    " PickerSystemlist() otherwise.
    "
    " Parameters
    " ----------
    " list_command : String
    "     Shell command to generate list user will choose from.
    " callback.on_select : String -> Void
    "     Function executed with the item selected by the user as the
    "     first argument.
    if exists('*termopen')
        call s:PickerTermopen(a:list_command, a:callback)
    else 
        call s:PickerTermStart(a:list_command, a:callback)
    endif
endfunction

function! PickFile(list_command, vim_command, ...) abort
    " Create a callback that executes a Vim command against the user's
    " selection escaped for use as a filename, and invoke Picker() with
    " that callback.
    "
    " Parameters
    " ----------
    " list_command : String
    "     Shell command to generate list user will choose from.
    " vim_command : String
    "     Readable representation of the Vim command which will be
    "     invoked against the user's selection, for display in the
    "     statusline.
    let l:callback = {'vim_command': a:vim_command}

    function! l:callback.on_select(selection) abort
		exec l:self.vim_command fnameescape(a:selection)
    endfunction

    call s:Picker(a:list_command, l:callback)
endfunction

function! Rg()
	let pattern = input('Rg/')

    let l:callback = {'vim_command': 'edit'}

    function! l:callback.on_select(selection) abort
		let l:fname = split(a:selection, ':')[0]
		exec l:self.vim_command fnameescape(l:fname)
    endfunction

    call s:Picker('rg --color never -M 120 "' . pattern . '"', l:callback)
endfunction

nmap <unique> <leader>e :call PickFile(ListFilesCommand(), 'edit')<CR>
nmap <unique> <leader>v :call PickFile(ListFilesCommand(), 'vsplit')<CR>
nmap <unique> <leader>p :call PickFile(ListBuffersCommand(), 'edit')<CR>
nmap <unique> <leader>t :call PickFile(ListTagsCommand(), 'vsplit')<CR>
nmap <unique> <leader>/ :call Rg()<CR>

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


