" TODO
" debug(vimspector, vim-delve, tsdebug)
" asynctasks.vim or test run plugin
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

call plug#begin('~/.config/nvim-coc/plugged')

"general
"Plug thesaneone/taskpaper.vim
Plug 'machakann/vim-sandwich'
Plug 'schickling/vim-bufonly'
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-rooter'
Plug 'romainl/vim-cool'
Plug 'romainl/vim-qf'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'wincent/ferret'
Plug 'mg979/vim-visual-multi'
Plug 'mbbill/undotree'
Plug 'bogado/file-line'
Plug 'regedarek/ZoomWin'

"themes
Plug 'arcticicestudio/nord-vim'
"Plug 'w0ng/vim-hybrid'

" Coding
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'honza/vim-snippets'
" Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
" Plug 'rhysd/reply.vim', { 'on': ['Repl', 'ReplAuto'] }
Plug 'previm/previm'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'samoshkin/vim-mergetool'
Plug 'ryanoasis/vim-devicons'
" Plug 'neovim/nvim-lsp'
" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/diagnostic-nvim'
" Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"js
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'

"python
Plug 'vim-python/python-syntax'

"golang
" Plug 'fatih/vim-go'
" Plug 'sebdah/vim-delve'
call plug#end()

"coc
let g:coc_global_extensions = ['coc-actions', 'coc-pairs', 'coc-restclient', 'coc-spell-checker', 'coc-explorer', 'coc-highlight', 'coc-snippets', 'coc-lists', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint', 'coc-html', 'coc-css', 'coc-pyright', 'coc-go', 'coc-react-refactor']

"----------------------------------------------
" General settings
"----------------------------------------------
"set python path separate from venvs
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" Disable vim distribution plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
" let g:loaded_matchit = 1
" let g:loaded_matchparen = 1
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

" autoread files
set autoread

" update faster
set updatetime=300

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

if has('termguicolors')
  set termguicolors " Use true colours
  colorscheme nord
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
" Plugin: vim-go
"----------------------------------------------
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_doc_popup_window=1

let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 0
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"

"----------------------------------------------
" Plugin: previm/previm
"----------------------------------------------
let g:previm_open_cmd = 'xdg-open'

"----------------------------------------------
" Plugin: floaterm
"----------------------------------------------
nnoremap <unique> <leader>tn  :FloatermNew --name=ft1 --wintype=normal --height=0.3 --autoclose=2<CR>
nnoremap <unique> <leader>t  :FloatermToggle<CR>
tnoremap <ESC><ESC> <C-\><C-N>


"----------------------------------------------
" Plugin: indent
"----------------------------------------------
let g:indentLine_char_list = ['┊']

""----------------------------------------------
"" Plugin: vim-cool
""----------------------------------------------
let g:CoolTotalMatches = 1
"----------------------------------------------
" Plugin: clap
"----------------------------------------------
nnoremap <unique> <leader>o  :Clap history<CR>
nnoremap <unique> <leader>p  :Clap files<CR>
nnoremap <unique> <leader>f  :Clap filer<CR>
nnoremap <unique> <leader>/  :Clap grep<CR>

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

let g:coc_snippet_next = '<tab>'

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
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
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
nmap <leader>gR <Plug>(coc-rename)

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

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Remap for do codeAction of current line
xmap <a-CR>  <Plug>(coc-codeaction)
nmap <a-CR>  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>ff  <Plug>(coc-fix-current)

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

" Using CocList
" Do default action for next item.
nnoremap <unique> ]n :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <unique> [n :<C-u>CocPrev<CR>

" " clap/fzf stuff
" nnoremap <unique> <leader>o  :<C-u>CocList mru<CR>
" nnoremap <unique> <leader>f  :<C-u>CocList files<CR>
" " Search workleader symbols
" nnoremap <unique> <leader>s  :<C-u>CocList -I symbols<cr>

" " grep word under cursor
" command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

" function! s:GrepArgs(...)
"   let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
"         \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
"   return join(list, "\n")
" endfunction

" " Keymapping for grep word under cursor with interactive mode
" nnoremap <unique> <leader>/ :exe 'CocList -I --input='.input('Rg/').' grep'<CR>

" coc explorer
nmap <unique> ge :CocCommand explorer<CR>


"----------------------------------------------
" Plugin: ale
"----------------------------------------------
" let g:ale_linters = {
"       \'javascript': ['eslint', 'prettier'],
"       \'typescript': ['tslint', 'eslint'],
"       \}
" let g:ale_linters_explicit = 1
" let g:ale_completion_enabled = 0
" let g:ale_sign_error = 'X'
" let g:ale_sign_warning = ''
" let g:ale_sign_column_always = 1
" let g:ale_completion_tsserver_autoimport = 1
" let g:ale_virtualtext_cursor = 1
" let g:ale_fixers = {
"       \'javascript': ['eslint', 'prettier'],
"       \'json': ['prettier'],
"       \'typescript': ['tslint', 'eslint'],
"       \'markdown': ['prettier'],
"       \}

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

" nmap <unique> ]d <Plug>(ale_previous_wrap)
" nmap <unique> [d <Plug>(ale_next_wrap)


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
" Plugin: vim-rest-console
"----------------------------------------------
" vim-rest-console
" let g:vrc_curl_opts = {
"   \ '--connect-timeout' : 10,
"   \ '-L': '',
"   \ '-i': '',
"   \ '-sS': '',
"   \ '--max-time': 60,
"   \ '-k': '',
" \}

"----------------------------------------------
" Plugin: nvim-treesitter
"----------------------------------------------
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"     highlight = {
"         enable = true,                    -- false will disable the whole extension
"         disable = { 'c' },        -- list of language that will be disabled
"     },
"     incremental_selection = {
"         enable = false,
"         disable = { 'cpp', 'lua' },
"         keymaps = {                       -- mappings for incremental selection (visual mappings)
"           init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
"           node_incremental = "grn",       -- increment to the upper named parent
"           scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
"           node_decremental = "grm",       -- decrement to the previous node
"         }
"     },
"     refactor = {
"       highlight_defintions = {
"         enable = false
"       },
"       smart_rename = {
"         enable = false,
"         smart_rename = "grr"              -- mapping to rename reference under cursor
"       },
"       navigation = {
"         enable = false,
"         goto_definition = "gnd",          -- mapping to go to definition of symbol under cursor
"         list_definitions = "gnD"          -- mapping to list all definitions in current file
"       }
"     },
"     ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
" }
" EOF



"----------------------------------------------
" Plugin: colorizer
"----------------------------------------------
" lua <<EOF
" require 'colorizer'.setup {
"   'css';
"   'javascript';
"   'typescript';
"   html = {
"     mode = 'foreground';
"   }
" }
" EOF



"----------------------------------------------
" Plugin: nvim-lsp
"----------------------------------------------
" lua <<EOF
" local nvim_lsp = require'nvim_lsp'

" local on_attach_vim = function()
"   require'diagnostic'.on_attach()
"   require'completion'.on_attach()
" end

" nvim_lsp.cssls.setup({on_attach=on_attach_vim})
" nvim_lsp.html.setup({on_attach=on_attach_vim})
" nvim_lsp.jsonls.setup({
"   cmd = {"json-languageserver", "--stdio"},
"   on_attach=on_attach_vim,
" })
" nvim_lsp.tsserver.setup({on_attach=on_attach_vim})
" --- nvim_lsp.efm.setup({on_attach=on_attach_vim})
" --- nvim_lsp.pyls_ms.setup({on_attach=on_attach_vim})
" --- nvim_lsp.gopls.setup({on_attach=on_attach_vim})

" EOF

" set omnifunc=v:lua.vim.lsp.omnifunc

" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> g=    <cmd>lua vim.lsp.buf.formatting()<CR>
" nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> <a-CR>    <cmd>lua vim.lsp.buf.code_action()<CR>

" call sign_define('LspDiagnosticsErrorSign', {'text' : 'X', 'texthl' : 'LspDiagnosticsError'})
" call sign_define('LspDiagnosticsWarningSign', {'text' : '', 'texthl' : 'LspDiagnosticsWarning'})
" call sign_define('LspDiagnosticInformationSign', {'text' : 'i', 'texthl' : 'LspDiagnosticsInformation'})
" call sign_define('LspDiagnosticHintSign', {'text' : 'H', 'texthl' : 'LspDiagnosticsHint'})

" let g:diagnostic_enable_virtual_text = 1

" nnoremap <unique> ]e <Cmd>NextDiagnosticCycle<CR>
" nnoremap <unique> [e <Cmd>PrevDiagnosticCycle<CR>

" " Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" " Set completeopt to have a better completion experience
" set completeopt=menu,menuone,noinsert,noselect

" " Avoid showing message extra message when using completion
" set shortmess+=c

" " trigger manual completion using tab
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ completion#trigger_completion()

" " possible value: 'UltiSnips', 'Neosnippet'
" let g:completion_enable_snippet = 'UltiSnips'

" " unset these as tab is used by haorenW1025/completion-nvim
" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsListSnippets="<F19>"
" let g:UltiSnipsExpandTrigger="<F19>"
" let g:UltiSnipsJumpForwardTrigger="<F19>"
" let g:UltiSnipsJumpBackwardTrigger="<F19>"

" inoremap <silent><expr> <C-Space> completion#trigger_completion()

" " Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()
" autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

" " auto swictch sources
" let g:completion_auto_change_source = 1

" " change completion matching strategy
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" " Chain completion list
" let g:completion_chain_complete_list = {
"       \ 'default' : [
"       \       {'complete_items': ['lsp', 'snippet']},
"       \       {'complete_items': ['path'], 'triggered_only': ['/']},
"       \       {'mode': '<c-p>'},
"       \       {'mode': '<c-n>'},
"       \       {'mode': 'file'}]
"       \ }

