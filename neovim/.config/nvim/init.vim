" TODO
" simple repl
" lua port
" nvim-lsp
" debug(vimspector, vim-delve, tsdebug)
" ---------------------------------------------
" workflow: new terminal window /pane (no tmuxes)
"----------------------------------------------
" Plugin management
"
" Download vim-plug from the URL below and follow the installation
" instructions:
" https://github.com/junegunn/vim-plug
"----------------------------------------------
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

"general
"Plug thesaneone/taskpaper.vim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'machakann/vim-sandwich'
Plug 'schickling/vim-bufonly'
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-rooter'
Plug 'romainl/vim-cool'
Plug 'romainl/vim-qf'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'wincent/ferret'
Plug 'mg979/vim-visual-multi'
Plug 'mbbill/undotree'
Plug 'bogado/file-line'
Plug 'regedarek/ZoomWin'
Plug 'gennaro-tedesco/nvim-peekup'

"themes
Plug 'bluz71/vim-nightfly-guicolors'

" Coding
Plug 'tpope/vim-fugitive'
Plug 'NTBBloodbath/rest.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'b3nj5m1n/kommentary'
Plug 'andymass/vim-matchup'
Plug 'kassio/neoterm'
Plug 'previm/previm'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'samoshkin/vim-mergetool'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"golang
" Plug 'fatih/vim-go'
" Plug 'sebdah/vim-delve'
call plug#end()

"coc
let g:coc_global_extensions = ['coc-actions', 'coc-pairs', 'coc-explorer', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint', 'coc-html', 'coc-css', 'coc-pyright', 'coc-go', 'coc-react-refactor']

"----------------------------------------------
" General settings
"----------------------------------------------
"set python path separate from venvs
let g:python_host_prog = 'python2'
let g:python3_host_prog = 'python3'

" Disable vim distribution plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_netrw = 1 
let g:loaded_netrwPlugin = 1 
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_remote_plugins = 1
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
let g:loaded_man = 1
let g:loaded_spellfile_plugin = 1

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
" set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')

" set title for terminal
set title

set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

" Setting up the directories
set nobackup                      " backups are nice ...
set nowritebackup
set lazyredraw                  " no unnecessary redraws
if has('persistent_undo')
  set undofile
  set undodir=~/.vimundo/
endif

" Enable mouse if possible
if has('mouse')
  set mouse=a
endif

" Allow vim to set a custom font or color for a word

set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set linespace=0                 " No extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,.git,.idea,build/*  " MacOSX/Linux
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
"set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimswap
"
" reopen last mark
autocmd BufReadPost * silent! normal! g`"zv

" enable spell for select files
autocmd FileType markdown,text setlocal spell spelllang=en_us complete+=k dictionary+=spell
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 filetype=javascriptreact
autocmd FileType typescript set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType go set tabstop=8 shiftwidth=8 softtabstop=8



" autoread files
set autoread

" update faster
set updatetime=100

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
"map <silent> <leader>cn :cn<CR>zv
"map <silent> <leader>cp :cp<CR>zv

"execute macros over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"----------------------------------------------
" Colors
"----------------------------------------------
set background=dark

if $TERM =~ "256color"
  set termguicolors " Use true colours
  colorscheme default
else
  set termguicolors " Use true colours
  colorscheme nightfly
  let g:nightflyCursorColor = 1
endif

"----------------------------------------------
" Searching
"----------------------------------------------
set inccommand=split          " enables interactive search and replace

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" highlight yank
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

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

function! GitStatus()
  return fugitive#head() != '' ? ' '.fugitive#head() : ''
endfunction

set statusline=
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
set statusline+=%#LineNr#
set statusline+=%=
set statusline+=\ %{coc#status()}
set statusline+=\ %{GitStatus()}
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}
" set statusline+=%#NonText#
" set statusline+=%#Normal#
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

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
" Plugin: vim-rooter
"----------------------------------------------
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['package.json', 'Readme.md', 'readme.md', 'README.md', '.vimroot', '.git/', 'venv/', 'vendor/']

augroup vimrc_rooter
    autocmd VimEnter * :Rooter
augroup END

"----------------------------------------------
" Plugin: previm/previm
"----------------------------------------------
let g:previm_open_cmd = 'xdg-open'

"----------------------------------------------
" Plugin: neoterm
"----------------------------------------------
nnoremap <unique> <leader>tl :<c-u>exec v:count.'Tclear'<cr>
nmap     <unique> gx <Plug>(neoterm-repl-send)
xmap     <unique> gx <Plug>(neoterm-repl-send)
let g:neoterm_default_mod=':vertical'

"----------------------------------------------
" Plugin: colorizer
"----------------------------------------------
lua <<EOF
require("colorizer").setup{
  'css';
  'javascript';
  'html';
  'haml';
  'sass';
  'javascriptreact';
  'typescriptreact';
}
EOF

"----------------------------------------------
" Plugin: indent
"----------------------------------------------
let g:indent_blankline_char = '│'
let g:indent_blankline_space_char = ' '
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_filetype_exclude = ['help', 'terminal']
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_current_context = v:true

""----------------------------------------------
"" Plugin: vim-cool
""----------------------------------------------
let g:CoolTotalMatches = 1
"----------------------------------------------
" Plugin: Telescope
"----------------------------------------------
nnoremap <unique> <leader>/  <cmd>Telescope live_grep<CR>
nnoremap <unique> <leader>p  <cmd>Telescope find_files<CR>
nnoremap <unique> <leader>f  <cmd>Telescope file_browser<CR>
nnoremap <unique> <leader>o  <cmd>Telescope oldfiles<CR>

lua <<EOF
require('telescope').setup{
 pickers = {
    -- Your special builtin config goes in here
    find_browser = {
      previewer = false,
    },
    oldfiles = {
      theme = "dropdown",
      previewer = false,
    },
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
  },
}
EOF

"----------------------------------------------
" Plugin: coc
"----------------------------------------------
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
"set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_status_error_sign = 'E: '
let g:coc_status_warning_sign = 'W: '

" remap js files
let g:coc_filetype_map = {
      \'javascript': 'javascriptreact',
      \ }

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
endif

" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <cmd>Telescope coc implementations<CR>
nmap <silent> gr <cmd>Telescope coc references<CR>
nmap <silent> gs <cmd>Telescope coc workspace_symbols<CR>
nmap <silent> gR <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for format selected region
xmap g=  <Plug>(coc-format-selected)
nmap g=  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType * setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction for entire file
nmap <a-CR>  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>a  <Plug>(coc-codeaction-line)
xmap <leader>a  <Plug>(coc-codeaction-selected)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc explorer
nmap <unique> ge :CocCommand explorer<CR>

"----------------------------------------------
" Plugin: vim-qf
"----------------------------------------------
nmap <unique> <F5> <Plug>(qf_qf_toggle)
nmap <unique> ]l <Plug>(qf_qf_previous)
nmap <unique> [l <Plug>(qf_qf_next)

"----------------------------------------------
" Plugin: vim-bufonly
"----------------------------------------------
nmap <unique> <leader>q <cmd>:Bonly<CR>

"----------------------------------------------
" Plugin: rest.nvim
"----------------------------------------------
nmap <unique> <leader>h <Plug>RestNvim<cr>

"----------------------------------------------
" Plugin: gitsigns
"----------------------------------------------

lua <<EOF
require('gitsigns').setup()
EOF

"----------------------------------------------
" Plugin: treesitter
"----------------------------------------------

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
    incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
   indent = {
    enable = true
  }, 
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
  },
}
EOF

