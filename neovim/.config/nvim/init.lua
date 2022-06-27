-- pre-requisites
--yarn global add typescript bash-language-server sql-language-server @fsouza/prettierd typescript-language-server vscode-langservers-extracted
--pip install --user pyright flake8 black autopep8 pylint
--do :TSInstall all to install all Treesitter parsers
--TODO debug mode
--TODO opttimize runtime?

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
  autocmd!
  autocmd BufWritePost init.lua source ~/.config/nvim/init.lua | PackerCompile
  augroup end
  ]],
  false
)

-- disable some builtin vim plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "matchparen",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "filetypes",
  "remote_plugins",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

local isEditor = function() 
    return os.getenv("TERMPURPOSE") == "editor"
end

-- Packer plugins
local use = require('packer').use
local util = require('packer.util')
require('packer').startup({function()
  -- general
  use { 
    'wbthomason/packer.nvim',
    event = "VimEnter",
  }
  use 'machakann/vim-sandwich'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = {'NvimTreeFindFileToggle', 'NvimTree'},
    config = function() require("nvim-tree").setup({
      git = {
        enable = true,
        ignore = false,
      },
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        }
    }) end
  }

  use { 'mbbill/undotree', cmd = 'UndotreeToggle' }

  use 'gennaro-tedesco/nvim-peekup'
  use 'nathom/filetype.nvim'
  use 'mg979/vim-visual-multi'
  use 'dyng/ctrlsf.vim'
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' } }
  use { "beauwilliams/focus.nvim", config = function() require("focus").setup({cursorline = false}) end }

  -- themes
  use { 'sainnhe/sonokai' }
  use { 
    'pgdouyon/vim-yin-yang',
    cond = isEditor
  }
  
  -- text editing
  use { 
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = {'markdown', 'text'},
    cond = isEditor
  }
  use {
    'krajeswaran/taskpaper.vim',
    cond = isEditor
  }
  use {
    'uga-rosa/cmp-dictionary',
    cond = isEditor,
    config = function() require("cmp_dictionary").setup({
      dic = {
        ["*"] = { "/usr/share/dict/words" },
        spelllang = {
          en = "/usr/share/hunspell/en_US.dic",
        },
      },
    })
    end
  }

  -- coding
  use 'andymass/vim-matchup'
  use 'AndrewRadev/splitjoin.vim'
  use 'samoshkin/vim-mergetool'
  use { 
    'ahmedkhalf/project.nvim',
  }
  use { 
    'sindrets/diffview.nvim',
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end,
    event = "BufRead",
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    event = "BufRead",
  }
  use { 
    'lewis6991/gitsigns.nvim', 
    event = 'BufRead',
    config = function() require("gitsigns").setup({
      attach_to_untracked = true,
      on_attach = function(bufnr)
        if vim.api.nvim_buf_get_name(bufnr):match('todo.md') then
          -- Don't attach to specific buffers whose name matches a pattern
          return false
        end

        local function map(mode, lhs, rhs, opts)
          opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
        map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

        -- Actions
        map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
        map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
        map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
        map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
        map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
        map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
        map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
        map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
        map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

        -- Text object
        map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }) end,
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufRead',
    run = function() vim.cmd("TSUpdate") end,
  }
  use { 'NTBBloodbath/rest.nvim', event = 'BufRead' }
  use { 
    'kassio/neoterm', 
    cmd = 'Tnew',
    config = function() vim.g.neoterm_default_mod = ':vertical'  end,
  }
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  }
  use {
    'norcalli/nvim-colorizer.lua',
    event = "BufRead",
    config = function() require("colorizer").setup({
      'css';
      'javascript';
      'html';
      'haml';
      'sass';
      'javascriptreact';
      'typescriptreact';
    }) end
  }
  use {
    "junegunn/goyo.vim",
    cmd = "Goyo"
  }
  use {
    'neovim/nvim-lspconfig', 
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'neovim/nvim-lspconfig',
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  }

  use {
    'hrsh7th/nvim-cmp', 
  }
  use {
    "rafamadriz/friendly-snippets",
  }
  use {
    "L3MON4D3/LuaSnip",
  }

  use {
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  }

  use {
    "hrsh7th/cmp-nvim-lsp",
  }

  use {
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  }

  use {
    "hrsh7th/cmp-path",
    after = "cmp-buffer",
  }

  use {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    after = "cmp-buffer",
  }

  use {
    "hrsh7th/cmp-cmdline",
    after = "cmp-path",
  }

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'windwp/nvim-autopairs',
    after='nvim-cmp',
    config = function()  
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt" , "terminal", "NvimTree", "vim" },
      })
    end
  }
  use {
    'kosayoda/nvim-lightbulb',
    'ray-x/lsp_signature.nvim',
    'nvim-lua/lsp-status.nvim',
    after='nvim-cmp',
    event='BufRead'
  }
  --[[ use {
    'mfussenegger/nvim-dap',
  }
  use {
    -- 'Pocco81/DAPInstall.nvim',
    -- 'rcarriga/nvim-dap-ui',
    after = {'mfussenegger/nvim-dap'},
    cmd = 'DebugOn'
  } ]]
end,
  config = {
    compile_path = util.join_paths(vim.fn.stdpath('data'), 'site/plugin', 'packer_compiled.lua'),
    display = {
      open_fn = function()
        return util.float({ border = 'single' })
      end
    }
  }
})

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Splits
vim.o.splitbelow = true
vim.o.splitright = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--clipboard
vim.o.clipboard = "unnamed,unnamedplus"

--line breaks
vim.o.linebreak = true

--show matching brackets
vim.o.showmatch = true

--Enable mouse mode
vim.o.mouse = 'a'

--title
vim.o.title = true

--virtualedit
vim.o.virtualedit = 'onemore'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true
vim.opt.undodir = util.join_paths(os.getenv('HOME'), '.nvimundo')

--backups
vim.o.backup = false
vim.o.writebackup = false

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--wild mode
vim.o.wildmode = "longest:list,full"
vim.o.wildignore = "'*/tmp/*', '*.so', '*.swp', '*.zip', '*.pyc', '.git', '.idea', 'build/*', '*/.DS_Store/*', '*/__pycache__/*'"

--Decrease update time
vim.o.updatetime = 100

--autoread
vim.o.autoread = true

--Set colorscheme 
vim.o.termguicolors = true
local term = os.getenv("TERMPURPOSE")
if term == "console" then
  vim.o.background = 'dark'
  vim.cmd [[
    colorscheme murphy
    highlight Pmenu guibg=0 ctermbg=0
    highlight SignColumn guibg=0 ctermbg=0
  ]]
elseif term == "editor" then
  vim.cmd [[
    colorscheme yin
    highlight EndOfBuffer guifg=#1c1c1c
  ]]
else
  vim.o.background = 'dark'
  if term == "api" then
    vim.g.sonokai_style = 'andromeda'
  else
    vim.g.sonokai_style = 'maia'
  end
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_show_eob = 0
  vim.g.sonokai_diagnostic_text_highlight = 1
  vim.g.sonokai_better_performance = 1
  vim.cmd [[colorscheme sonokai]]
end

--set whichwrap
vim.o.whichwrap = "b,s,h,l,<,>,[,]"

--don't insert comments while pasting
vim.bo.formatoptions = vim.bo.formatoptions:gsub("r", '')
vim.bo.formatoptions = vim.bo.formatoptions:gsub("o", '')

-- set paste
vim.o.pastetoggle='<F2>'

-- diff options
vim.o.diffopt = vim.o.diffopt .. ",vertical,indent-heuristic,iwhiteall,algorithm:patience"

-- tab / indent stuff
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

--path
vim.opt.path = vim.opt.path + '**'

--scroll stuff
vim.o.scrolljump=5
vim.o.scrolloff=2   

-- visual search
vim.o.inccommand = 'split'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- open last mark
vim.cmd [[
augroup last_edit
autocmd!
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]]

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false
)

-- Key mappings --

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--terminal
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true })

--quick save
vim.api.nvim_set_keymap('n', '<Leader>x', ':wq<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- easier window moving
vim.api.nvim_set_keymap('', '<C-S-Down>', '<C-W>j<C-W>_', {})
vim.api.nvim_set_keymap('', '<C-S-Up>', '<C-W>h<C-W>_', {})
vim.api.nvim_set_keymap('', '<C-S-Right>', '<C-W>l<C-W>_', {})
vim.api.nvim_set_keymap('', '<C-S-Left>', '<C-W>h<C-W>_', {})

-- easier code folding
vim.api.nvim_set_keymap('n', '<Leader>f0', ':set foldlevel=0<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f1', ':set foldlevel=1<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f2', ':set foldlevel=2<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f3', ':set foldlevel=3<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f4', ':set foldlevel=4<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f5', ':set foldlevel=5<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f6', ':set foldlevel=6<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f7', ':set foldlevel=7<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f8', ':set foldlevel=8<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>f9', ':set foldlevel=9<CR>', {})

-- cd shortcuts
vim.api.nvim_set_keymap('c', 'cwd', 'lcd %:p:h', {})
vim.api.nvim_set_keymap('c', 'cd.', 'lcd %:p:h', {})

-- visual shifting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true})

-- sudo
vim.api.nvim_set_keymap('c', 'w!!', '!sudo tee % >/dev/null', {})

-- adjust view ports
vim.api.nvim_set_keymap('n', '<Leader>=', '<C-w>=', { noremap = true })

-- spell check
vim.api.nvim_set_keymap('n', '<F7>', ':setlocal spell spelllang=en', {})

-- make search result centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- json format
vim.api.nvim_set_keymap('n', '<leader>jt', '<Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>', {})


-- text editing
vim.cmd [[
augroup texting
  autocmd!
  set spelllang=en

  autocmd FileType markdown,text,taskpaper set autowriteall
  autocmd TextChanged,TextChangedI scratch.md silent write  

  autocmd BufRead,BufNewFile todo.md set ft=taskpaper 
  autocmd BufRead,BufNewFile todo.md :Goyo 80
  autocmd BufRead,BufNewFile todo.md set statusline=
  autocmd BufWritePost todo.md call timer_start(1000, {-> execute("echo ''", "")})
  autocmd TextChanged,TextChangedI todo.md silent write  
  autocmd VimEnter todo.md  setlocal complete=k/~/notes/journal/**/*

  autocmd BufRead,BufNewFile todo.md set statusline=
  autocmd BufWritePost */journal/** call timer_start(1000, {-> execute("echo ''", "")})
  autocmd TextChanged,TextChangedI */journal/** silent write  
  autocmd VimEnter */journal/**  setlocal complete=k/~/notes/journal/**/*
augroup END
]]

_G.JournalMode = function()
  -- open journal file with date
  local fname = util.join_paths(os.getenv('HOME'), 'notes', 'journal', os.date("%Y"), os.date("%d%b") .. ".md")
  local skeleton = util.join_paths(os.getenv('HOME'), 'notes', 'journal', 'journal.skeleton')
  vim.api.nvim_command('e ' .. fname)
  vim.api.nvim_command('0r ' .. skeleton)
  vim.api.nvim_command('Goyo')
  vim.api.nvim_command('set statusline=')
  vim.api.nvim_command('set signcolumn=no')
  vim.api.nvim_command('set spell!')
end

_G.ScratchPad = function()
  -- open journal file with date
  local fname = util.join_paths(os.getenv('HOME'), 'scratch.md')
  vim.api.nvim_command('e ' .. fname)
  vim.api.nvim_command('Goyo')
  vim.api.nvim_command('set statusline=')
  vim.api.nvim_command('set signcolumn=no')
  vim.api.nvim_command('set autowriteall')
end

vim.api.nvim_set_keymap('n', '<leader>j', ':lua JournalMode()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>je', ':!~/bin/send-journal %<CR>', { noremap = true })
vim.cmd [[ command! Journal execute 'lua JournalMode()' ]]
vim.cmd [[ command! Scratch execute 'lua ScratchPad()' ]]

-- statusline --

local lspstatus = require('lsp-status')

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
lspstatus.config({
  indicator_errors = signs['Error'],
  indicator_warnings = signs['Warn'],
  indicator_info = signs['Info'],
  indicator_hint = signs['Hint'],
  indicator_ok = '',
  status_symbol = '',
})
if not isEditor() then
  lspstatus.register_progress()
end

display_lsp_diagnostics = function()
  if isEditor() or vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
    return ''
  end
  local status = lspstatus.status()
  if status == ' ' then
    return ' '
  end
  return status
end

display_paste = function()
  local result = ""
  local paste = vim.go.paste
  if paste then
    result = "  "
  end
  return result
end

display_readonly = function()
  local ro = vim.bo.readonly
  local mod = vim.bo.modifiable
  if (ro and not mod) or not mod then
    return " "
  elseif ro then
    return " "
  else
    return ""
  end
end

display_modified = function()
  if vim.bo.modified then
    return "● "
  else
    return ""
  end
end

display_filetype = function()
  local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  return icon
end

display_metadata = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lhs = ""
  local rhs = ""
  local format = vim.api.nvim_buf_get_option(bufnr, "fileformat")
  local encoding = vim.api.nvim_buf_get_option(bufnr, "fileencoding")
  if #format > 0 and format ~= "unix" then
    lhs = format
  end
  if #encoding > 0 and encoding ~= "utf-8" then
    rhs = encoding
  end
  if #lhs > 0 and #rhs > 0 then
    return vim.fn.join({ lhs, rhs }, " | ")
  else
    return string.format(" %s %s ", lhs, rhs)
  end
end

display_buffer = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local icon = " "
  for i, b in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr == b then
      return icon .. i
    end
  end
end

display_git_status= function()
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
  local is_head_empty = signs.head ~= ''

  return is_head_empty and string.format(
    ' +%s ~%s -%s |  %s ',
    signs.added, signs.changed, signs.removed, signs.head
  ) or ''
end

Statusline = function()
  local color = '%#LineNr#'
  local filename = ' %f '
  local filestat1 = display_modified()
  local filestat2 = display_readonly()
  local git_status = display_git_status()
  local diagnostics = display_lsp_diagnostics()
  local separator = '%='
  local ft = display_filetype()
  local metadata = display_metadata()
  local percent_indicator = ' %p%% '
  local line_indicator = ' %l:%c'

  return table.concat({ color, filename, filestat1, filestat2, diagnostics, separator, git_status, ft, metadata, percent_indicator, line_indicator})
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline()
  au FileType taskpaper,NvimTree,Terminal set statusline=
  augroup END
]], false)


-- plugins --

-- replacer
vim.api.nvim_set_keymap('n', '<Leader>r', ':lua require("replacer").run()<cr>', { silent = true })

--project.nvim
require("project_nvim").setup {
  patterns = { ".git", "venv/", "vendor/", ".hg", ".bzr", ".svn", "Makefile", "package.json", "README.md", "Readme.md" },
}

--nvim-tree
vim.g.nvim_tree_respect_buf_cwd = 1
vim.api.nvim_set_keymap('n', 'ge', ':NvimTreeFindFileToggle<CR>', { noremap = true })

-- Indent blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_current_context = true

-- Telescope
require('telescope').setup {
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

vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'z=', [[<cmd>lua require('telescope.builtin').spell_suggest()<CR>]], { noremap = true, silent = true })

-- Treesitter 
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'
vim.o.foldlevel=99

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
  },
  context_commentstring = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- OR command

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', [[:Telescope lsp_code_actions<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', 'ga', '[[:Telescope lsp_range_code_action<CR>]]', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', [[:Telescope lsp_dynamic_workspace_symbols<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', 'g=', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- save on formatting
  vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
end

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

local telescope = require('telescope.builtin')
vim.lsp.handlers["textDocument/codeAction"] = telescope.lsp_code_actions
vim.lsp.handlers["textDocument/declaration"] = telescope.lsp_definitions
vim.lsp.handlers["textDocument/definition"] = telescope.lsp_definitions
vim.lsp.handlers["textDocument/documentSymbol"] = telescope.lsp_document_symbols
vim.lsp.handlers["textDocument/implementation"] = telescope.lsp_implementations
vim.lsp.handlers["textDocument/references"] = telescope.lsp_references
vim.lsp.handlers["textDocument/typeDefinition"] = telescope.lsp_definitions
vim.lsp.handlers["workspace/symbol"] = telescope.lsp_workspace_symbols

-- null-ls setup
local null_ls = require('null-ls')
if isEditor() then 
  null_ls.setup({
    sources = {
      -- completions
      -- null_ls.builtins.completion.spell,
      null_ls.builtins.diagnostics.vale,

      -- formatting sources
      null_ls.builtins.formatting.autopep8, 
      null_ls.builtins.formatting.black, 
      null_ls.builtins.formatting.json_tool,
    },
    on_attach = on_attach
  }) 
else 
  null_ls.setup({
    sources = { 
      -- code action sources
      -- null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,

      -- completions
      -- null_ls.builtins.completion.spell,

      -- diagnostic sources
      -- null_ls.builtins.diagnostics.codespell, 
      -- null_ls.builtins.diagnostics.cppcheck, 
      -- null_ls.builtins.diagnostics.eslint_d, 
      -- null_ls.builtins.diagnostics.pylint, 
      null_ls.builtins.diagnostics.flake8, 
      -- null_ls.builtins.diagnostics.shellcheck, 

      -- formatting sources
      null_ls.builtins.formatting.autopep8, 
      null_ls.builtins.formatting.black, 
      -- null_ls.builtins.formatting.codespell, 
      null_ls.builtins.formatting.json_tool,
      -- null_ls.builtins.formatting.lua_format,
      null_ls.builtins.formatting.prettierd, 
      -- null_ls.builtins.formatting.shfmt, 
      null_ls.builtins.formatting.sqlformat, 
      null_ls.builtins.formatting.terraform_fmt, 
      -- null_ls.builtins.formatting.uncrustify, 
    },
    on_attach = on_attach
  })
end

-- nvim-cmp setup
local LSP_KIND_SIGNS = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require 'cmp'
local luasnip = require("luasnip")
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ['<C-Space>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<CR>'] =  cmp.mapping(cmp.mapping.confirm { select = true }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority=8, max_item_count = 25 },
    { name = "luasnip", priority=6 },
    { name = 'buffer', priority=7, keyword_length = 4},
    { name = "nvim_lsp_signature_help" },
    { name = 'path', priority=6, keyword_length = 4 },
    { name = 'dictionary', priority=6, keyword_length = 5 },
  }),

  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = 'C',
        buffer   = 'B',
        path = 'P',
        snippet = 'S',
      })[entry.source.name]

      -- vim_item.kind = string.format("%s %s", LSP_KIND_SIGNS[vim_item.kind], vim_item.kind)
      vim_item.kind = LSP_KIND_SIGNS[vim_item.kind]
      return vim_item
    end
  },

   sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  }),

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
	{ name = 'cmdline' }
      })
  })
}

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities(), {
    snippetSupport = false,
})

-- Enable the following language servers
local servers = { 'pyright', 'tsserver', 'eslint', 'html', 'cssls', 'bashls', 'sqlls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  }
end

--sqlls setup
require'lspconfig'.sqlls.setup{
  cmd = {"sql-language-server", "up", "--method", "stdio"};
}

-- tsserver override setup

-- make sure to only run this once!
nvim_lsp.tsserver.setup {
  -- Only needed for inlayHints. Merge this table with your settings or copy
  -- it from the source if you want to add your own init_options.
  init_options = require("nvim-lsp-ts-utils").init_options,

  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
      enable_import_on_completion = true,

      -- eslint
      --[[ eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true, ]]

      -- formatting
      enable_formatting = true,
      formatter = "prettierd",

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = true,
    }

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    vim.cmd [[ command! OR execute ':TSLspOrganize' ]]
  end
}

-- lightbulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- RestNvim
vim.cmd [[
nmap <leader>h <Plug>RestNvim<CR>
]]

--[[ -- DAP
local dap_install = require("dap-install")
dap_install.config("python", {})
dap_install.config("chrome", {}) ]]

-- lsp signature
require "lsp_signature".setup()

-- refactoring
local refactor = require("refactoring")
refactor.setup({})

-- telescope refactoring helper
local function refactor(prompt_bufnr)
    local content = require("telescope.actions.state").get_selected_entry(
        prompt_bufnr
    )
    require("telescope.actions").close(prompt_bufnr)
    require("refactoring").refactor(content.value)
end

_G.refactors = function()
    local opts = require("telescope.themes").get_cursor() -- set personal telescope options
    require("telescope.pickers").new(opts, {
        prompt_title = "refactors",
        finder = require("telescope.finders").new_table({
            results = require("refactoring").get_refactors(),
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(_, map)
            map("i", "<CR>", refactor)
            map("n", "<CR>", refactor)
            return true
        end
    }):find()
end

vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rt", [[ <Esc><Cmd>lua M.refactors()<CR>]], {noremap = true, silent = true, expr = false})

