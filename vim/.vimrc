" Environment {
    " Basics {
        set nocompatible        " must be first line
        set background=dark     " Assume a dark background
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    "
    " Setup pathogen Support {
        " pathogen - turning off as this affects rest of the settings like indent etc
        call pathogen#infect()
        syntax on
        filetype plugin indent on
        call pathogen#helptags()
    " }
" }


" General {
    set mouse=a                 " automatically enable mouse usage
    set go+=a
    set splitbelow
    set splitright
    set showfulltag
    set clipboard=unnamed
    set clipboard=unnamedplus
    scriptencoding utf-8
    "imap ^V ^O"+p
    "set shellcmdflag=-ic
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    "set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set hidden                      " allow buffer switching without saving

    " Setting up the directories {
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
    " }
" }

" Vim UI {
    "set tabpagemax=15               " only show 15 tabs
    "set showmode                    " display the current mode

    "autocmd FileType text setlocal textwidth=78
    set wrap
    set linebreak
    set nolist  " list disables linebreak
    set textwidth=0
    set wrapmargin=0
    set formatoptions+=l
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
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip  " MacOSX/Linux
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=2                 " minimum lines to keep above and below cursor
    "set foldenable                  " auto fold code
    "set list
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace


" }

" Formatting {
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    "set matchpairs+=<:>                " match, to be used with %
    set paste                       " no indent on paste
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

    " Remove trailing whitespaces and ^M chars
    "autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " shiftwidth for specific files
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
    autocmd FileType twiki setlocal shiftwidth=3 tabstop=3

    " other niceties
    set mousemodel=popup

    set grepformat=%f:%l:%m

    set diffopt=filler,context:4,vertical
    set makeprg=g++\ \\\--std=c++0x\ \\\\{$*}

    " directories
    set viewdir=$HOME/.vimviews
    set backupdir=$HOME/.vimbackup
    set directory=$HOME/.vimswap
" }

" Key (re)Mappings {

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
    map <silent> <leader>n :cn<CR>zv
    map <silent> <leader>p :cp<CR>zv
" }


" Plugins {

    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
        let g:NERDTreeMinimalUI = 1
    " }

    " OmniComplete {
    "if has("autocmd") && exists("+omnifunc")
        "autocmd Filetype *
                    "\if &omnifunc == "" |
                    "\setlocal omnifunc=syntaxcomplete#Complete |
                    "\endif
    "endif

     "set completeopt="longest,menuone,preview"

     """ Enable omni completion.
     "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
     "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
     "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
     "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
     "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
     "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
     "autocmd FileType ruby let g:rubycomplete_buffer_loading=1
     "autocmd FileType ruby let g:rubycomplete_classes_in_global=1


     "inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
     "inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
    "" }

    "" easytags {
    "    set tags=./tags;/,~/.vimtags
    "    let g:easytags_cmd='/usr/bin/ctags'
    "    let g:easytags_async=1
    "" }

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
    " }

    " Tabularize {
        if exists(":Tabularize")
          nmap <Leader>a= :Tabularize /=<CR>
          vmap <Leader>a= :Tabularize /=<CR>
          nmap <Leader>a: :Tabularize /:<CR>
          vmap <Leader>a: :Tabularize /:<CR>
          nmap <Leader>a:: :Tabularize /:\zs<CR>
          vmap <Leader>a:: :Tabularize /:\zs<CR>
          nmap <Leader>a, :Tabularize /,<CR>
          vmap <Leader>a, :Tabularize /,<CR>
          nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
          vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

          " The following function automatically aligns when typing a
          " supported character
          inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

          function! s:align()
              let p = '^\s*|\s.*\s|\s*$'
              if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
                  let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
                  let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
                  Tabularize/|/l1
                  normal! 0
                  call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
              endif
          endfunction

        endif
     " }

     " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
     " }

     " ctrlp {
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
     "}

     "" TagBar {
     "   nnoremap <silent> <leader>tt :TagbarToggle<CR>
     "   let g:tagbar_left = 1
     ""}

     "" Fugitive {
     "   nnoremap <silent> <leader>gs :Gstatus<CR>
     "   nnoremap <silent> <leader>gd :Gdiff<CR>
     "   nnoremap <silent> <leader>gc :Gcommit<CR>
     "   nnoremap <silent> <leader>gb :Gblame<CR>
     "   nnoremap <silent> <leader>gl :Glog<CR>
     "   nnoremap <silent> <leader>gp :Git push<CR>
     ""}

     "" neocomplcache {
     "   "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
     "   " Disable AutoComplPop.
     "   let g:acp_enableAtStartup = 0
     "   " Use neocomplete.
     "   let g:neocomplete#enable_at_startup = 1
     "   " Use smartcase.
     "   let g:neocomplete#enable_smart_case = 1
     "   " Set minimum syntax keyword length.
     "   let g:neocomplete#sources#syntax#min_keyword_length = 3
     "   let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

     "   " Define dictionary.
     "   let g:neocomplete#sources#dictionary#dictionaries = {
     "       \ 'default' : '',
     "       \ 'vimshell' : $HOME.'/.vimshell_hist',
     "       \ 'scheme' : $HOME.'/.gosh_completions'
     "           \ }

     "   " Define keyword.
     "   if !exists('g:neocomplete#keyword_patterns')
     "       let g:neocomplete#keyword_patterns = {}
     "   endif
     "   let g:neocomplete#keyword_patterns['default'] = '\h\w*'

     "   " Plugin key-mappings.
     "   inoremap <expr><C-g>     neocomplete#undo_completion()
     "   inoremap <expr><C-l>     neocomplete#complete_common_string()

     "   " Recommended key-mappings.
     "   " <CR>: close popup and save indent.
     "   inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
     "   function! s:my_cr_function()
     "     return neocomplete#close_popup() . "\<CR>"
     "     " For no inserting <CR> key.
     "     "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
     "   endfunction
     "   " <TAB>: completion.
     "   inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
     "   " <C-h>, <BS>: close popup and delete backword char.
     "   inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
     "   inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
     "   inoremap <expr><C-y>  neocomplete#close_popup()
     "   inoremap <expr><C-e>  neocomplete#cancel_popup()
     "   " Close popup by <Space>.
     "   "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

     "   " For cursor moving in insert mode(Not recommended)
     "   "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
     "   "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
     "   "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
     "   "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
     "   " Or set this.
     "   "let g:neocomplete#enable_cursor_hold_i = 1
     "   " Or set this.
     "   "let g:neocomplete#enable_insert_char_pre = 1

     "   " AutoComplPop like behavior.
     "   "let g:neocomplete#enable_auto_select = 1

     "   " Shell like behavior(not recommended).
     "   "set completeopt+=longest
     "   "let g:neocomplete#enable_auto_select = 1
     "   "let g:neocomplete#disable_auto_complete = 1
     "   "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

     "   " Enable omni completion.
     "   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
     "   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
     "   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
     "   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
     "   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

     "   " Enable heavy omni completion.
     "   if !exists('g:neocomplete#sources#omni#input_patterns')
     "     let g:neocomplete#sources#omni#input_patterns = {}
     "   endif
     "   "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
     "   "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
     "   "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

     "" }

    "" taskpaper {
     "   let g:task_paper_archive_file = 'Dropbox/todo/archive_todo.txt'
    "" }
    
    " singlecompile {
        nmap <F9> :SCCompile<cr>
        nmap <F10> :SCCompileRun<cr>
        let g:SingleCompile_showquickfixiferror = 1
        let g:SingleCompile_showresultafterrun = 1
    " }

    " syntastic {
        let g:syntastic_cpp_compiler = 'g++'
        let g:syntastic_cpp_compiler_options = ' -std=c++11'
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
    " }

    " airline {
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
    " }
" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    set t_Co=256
    let g:hybrid_use_Xresources = 1
    colorscheme hybrid
    "let g:base16colorspace=256
    "colorscheme base16-colors
    if has('gui_running')
        "colo my_murphy  
        set lines=30  "30 lines of text window size
        "set guifont=Terminus\ Bold\ 12
        set guifont=Source\ Code\ Pro\ Semibold\ 8.5 
        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
    endif
" }

" Functions {
" }

