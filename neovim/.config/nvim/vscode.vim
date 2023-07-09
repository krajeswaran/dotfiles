if !exists('g:vscode')
  finish
endif

filetype plugin off

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

" Usually installed system-wide, so disable it by the parameter
let g:loaded_fzf = v:false

set splitbelow
set splitright
set showfulltag
set clipboard^=unnamed,unnamedplus
scriptencoding utf-8
set encoding=utf-8
set history=1000                " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

" autoread files
set autoread

" update faster
set updatetime=100

" Setting up the directories
set nobackup                      " backups are nice ...
set nowritebackup
set lazyredraw                  " no unnecessary redraws
if has('persistent_undo')
  set undofile
  set undodir=~/.vimundo/
endif
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

" directories
" set viewdir=$HOME/.vimview
"set backupdir=$HOME/.vimbackup
" set directory=$HOME/.vimswap
"
" reopen last mark
autocmd BufReadPost * <cmd>Call VSCodeNotify('workbench.action.navigateToLastEditLocation')<CR>
let mapleader = "\<Space>"

" quick save
nnoremap <Leader>x :wq<CR>

" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :

" Movement around wrapped lines
nmap j gj
nmap k gk

" Unmap default multicursors command to use m for move
xunmap ma
xunmap mi
xunmap mA
xunmap mI

nnoremap ge i<Cmd>call VSCodeNotify('workbench.files.action.focusFilesExplorer')<CR>
nnoremap <Leader>t i<Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>

" Open-browser-like
nnoremap gx <Cmd>call VSCodeNotify('editor.action.openLink')<CR>

" Unimpaired-like, treat VSCode tabs like buffers
nnoremap ]b <Cmd>Tabnext<CR>
nnoremap [b <Cmd>Tabprevious<CR>

" Commentary-like
xmap gc <Plug>VSCodeCommentary
nmap gc <Plug>VSCodeCommentary
omap gc <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" undo 
nnoremap <silent> u :<C-u>call VSCodeNotify('undo')<CR>
nnoremap <silent> <C-r> :<C-u>call VSCodeNotify('redo')<CR>

" GitGutter-like
nnoremap ]c <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
nnoremap [c <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
nnoremap <Leader>hs <Cmd>call VSCodeNotify('git.stageSelectedRanges')<CR>
nnoremap <Leader>hu <Cmd>call VSCodeNotify('git.unstageSelectedRanges')<CR>
nnoremap <Leader>hr <Cmd>call VSCodeNotify('git.revertSelectedRanges')<CR>
nnoremap <Leader>hp <Cmd>call VSCodeNotify('editor.action.dirtydiff.next')<CR>
" Fugitive-like
nnoremap <Leader>gd <Cmd>call VSCodeNotify('git.openChange')<CR>

" Remap keys for gotos
nmap <silent> <C-]> <Cmd>call VSCodeNotify('editor.action.goToDeclaration')<CR>
nmap <silent> gd <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
nmap <silent> gD <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>
nmap <silent> gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
nmap <silent> gR <Cmd>call VSCodeNotify('editor.action.rename')<CR>
noremap gr i<Cmd>call VSCodeNotify('references-view.find')<CR>
noremap gs <Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
nnoremap <silent> K <Cmd>call VSCodeNotify('workbench.action.showDefinitionPreviewHover')<CR>

" Fix autofix problem of current line
nnoremap ga <Cmd>call VSCodeNotify('editor.action.codeAction')<CR>

" TODO organize imports

"editor.action.goToDeclaration
"editor.action.revealDefinition
"editor.action.openDeclarationToTheSide
"editor.action.revealDefinitionAside
"editor.action.previewDeclaration
"editor.action.peekDefinition
"editor.action.revealDeclaration
"editor.action.peekDeclaration
"editor.action.goToTypeDefinition
"editor.action.peekTypeDefinition
"editor.action.goToImplementation
"editor.action.peekImplementation
"editor.action.goToReferences
"editor.action.referenceSearch.trigger
"editor.action.goToLocations
"editor.action.peekLocations
"editor.action.findReferences
"editor.action.showReferences
"editor.action.showHover
"editor.action.showDefinitionPreviewHover
"editor.action.quickFix
"editor.action.refactor
"editor.action.sourceAction
"editor.action.organizeImports
"editor.action.autoFix
"editor.action.fixAll
"editor.action.codeAction

nnoremap <unique> <leader>o  <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <unique> <leader>/  <Cmd>call VSCodeNotify('search.action.revealInSideBar')<CR>
" nnoremap <unique> <leader>f  <cmd>Telescope file_browser<CR>
" nnoremap <unique> <leader>p  <cmd>Telescope oldfiles<CR>

" Visual-Multi-like TODO
nnoremap <A-m> i<Cmd>call VSCodeNotify('editor.action.addSelectionToNextFindMatch')<CR>
vnoremap <A-m> <Esc>i<Cmd>lua require'vscode'.command_on_last_selection('editor.action.addSelectionToNextFindMatch')<CR>
nnoremap <C-Down> i<Cmd>call VSCodeNotify('editor.action.insertCursorBelow')<CR>
nnoremap <C-Up> i<Cmd>call VSCodeNotify('editor.action.insertCursorAbove')<CR>

" Diagnostic jumping
nnoremap [d <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
nnoremap ]d <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
nnoremap [D <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>
nnoremap ]D <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>

" Tab control TODO
noremap Q <Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>
nnoremap <C-x> <Cmd>call VSCodeCall('workbench.action.files.save')<CR><Cmd>Tabclose<CR>

" Use == for reindent instead of LSP formatting TODO
nnoremap == <Cmd>call VSCodeNotify('editor.action.reindentselectedlines')<CR>
nnoremap g= <Cmd>call VSCodeNotify('editor.action.formatSelection')<CR>
xnoremap = <Cmd>lua require'vscode'.visual_mode_command('editor.action.reindentselectedlines')<CR>
xnoremap g= <Cmd>lua require'vscode'.visual_mode_command('editor.action.formatSelection')<CR>

" Zen  TODO
nnoremap <Leader>Z <Cmd>call VSCodeNotify('workbench.action.toggleZenMode')<CR>
nnoremap <Leader>z <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility') | call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>
