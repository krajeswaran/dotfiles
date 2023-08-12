-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- TODO taskpaper/notes mode

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/" .. ".nvimundo"

-- backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- no numbers
vim.opt.number = false
vim.opt.relativenumber = false

-- no cursorline
vim.opt.cursorline = false
vim.opt.wrap = true

-- autoread
vim.opt.autoread = true

-- no tabline
vim.opt.showtabline = 0

-- no SignColumn
vim.opt.signcolumn = "auto"

-- open last mark
vim.cmd([[
augroup last_edit
autocmd!
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]])

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

-- Set colorscheme
local term = os.getenv("TERMPURPOSE")
if term == "console" then
  vim.opt.background = "dark"
  vim.cmd([[
    colorscheme murphy
    highlight Pmenu guibg=0 ctermbg=0
    highlight SignColumn guibg=0 ctermbg=0
    ]])
elseif term == "editor" then
  vim.cmd([[
    colorscheme yin
    highlight EndOfBuffer guifg=#1c1c1c
    ]])
else
  vim.opt.background = "dark"
  if term == "api" then
    vim.g.sonokai_style = "andromeda"
  else
    vim.g.sonokai_style = "maia"
  end
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_show_eob = 0
  vim.g.sonokai_diagnostic_text_highlight = 1
  vim.g.sonokai_better_performance = 1
  vim.cmd([[colorscheme sonokai]])
end

-- set whichwrap
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"

-- don't insert comments while pasting
vim.bo.formatoptions = vim.bo.formatoptions:gsub("r", "")
vim.bo.formatoptions = vim.bo.formatoptions:gsub("o", "")

-- set paste
vim.opt.pastetoggle = "<F2>"

-- diff options
vim.opt.diffopt = vim.o.diffopt .. ",vertical,indent-heuristic,iwhiteall,algorithm:patience"

-- tab / indent stuff
vim.opt.softtabstop = 2
