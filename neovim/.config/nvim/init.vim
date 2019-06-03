" TODO
" - auto install coc plugins, install coc-snippet
" - cleanup coc config: see reddit for inspiration
" - add vim-rest-client
"----------------------------------------------
" Plugin management
"
" Download vim-plug from the URL below and follow the installation
" instructions:
" https://github.com/junegunn/vim-plug
"----------------------------------------------
call plug#begin('~/.config/nvim/plugged')

" General plugins
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-rooter'
Plug 'junegunn/goyo.vim'

" Coding
Plug 'mhinz/vim-signify'
Plug 'rhysd/git-messenger.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'julienr/vim-cellmode'
" Plug 'neoclide/coc-tsserver', 
" Plug 'neoclide/coc-tslint-plugin', 
" Plug 'neoclide/coc-json', 
" Plug 'neoclide/coc-java', 
" Plug 'neoclide/coc-gocode', 
" Plug 'neoclide/coc-vetur',
" Plug 'neoclide/coc-lists',
" Plug 'neoclide/coc-css', 
" Plug 'neoclide/coc-html', 
" Plug 'neoclide/coc-python',
" Plug 'neoclide/coc-highlight',

" golang

" python

" javascript

call plug#end()

"----------------------------------------------
" General settings
"----------------------------------------------
"set python path separate from venvs
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

set mouse=a                 " automatically enable mouse usage
set go+=a
set splitbelow
set splitright
set showfulltag
set clipboard^=unnamed,unnamedplus
scriptencoding utf-8
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
"set virtualedit=onemore         " allow for cursor beyond last character
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


set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set linespace=0                 " No extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,.git,.idea  " MacOSX/Linux
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen


" Formatting
set pastetoggle=<F2>                       " no indent on paste


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
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE

" flag bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
highlight EndOfBuffer ctermbg=black ctermfg=black 

"----------------------------------------------
" Searching
"----------------------------------------------
set inccommand=split          " enables interactive search and replace

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
set statusline+=\ %{coc#status()}
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}
" set statusline+=%#NonText#
set statusline+=%#Normal#
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

"----------------------------------------------
" Plugin: rhysd/git-messenger
"----------------------------------------------
let g:git_messenger_include_diff="current"

"----------------------------------------------
" Plugin: christoomey/vim-tmux-navigator
"----------------------------------------------
" Tmux vim integration
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

" Move between splits with ctrl+h,j,k,l
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

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
let g:rooter_patterns = ['.vimroot', '.git/', 'venv/', 'vendor/']

augroup vimrc_rooter
    autocmd VimEnter * :Rooter
augroup END


"----------------------------------------------
" Plugin: coc
"----------------------------------------------

" complete
" set showmode shortmess+=c
" set completeopt-=preview
" set completeopt+=longest,menu,menuone,noinsert


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <leader>cn <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cp <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
