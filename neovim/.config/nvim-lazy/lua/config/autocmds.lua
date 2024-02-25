-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- color fuckery
local term = os.getenv("TERMPURPOSE")
if term == "console" then
  vim.cmd.colorscheme("tokyonight-night")
  -- vim.cmd([[
  --   colorscheme murphy
  --   highlight Pmenu guibg=0 ctermbg=0
  --   highlight SignColumn guibg=0 ctermbg=0
  --   ]])
elseif term == "editor" then
  vim.cmd([[
    colorscheme yin
    highlight EndOfBuffer guifg=#1c1c1c
    ]])
else
  if term == "api" then
    vim.cmd([[colorscheme catppuccin]])
  else
    vim.cmd([[colorscheme tokyonight-night]])
  end
end

-- text editing
vim.cmd([[
augroup texting
autocmd!
set spelllang=en

autocmd FileType markdown,text,taskpaper set autowriteall
autocmd TextChanged,TextChangedI scratch.md silent write  

autocmd BufRead,BufNewFile todo.md :Goyo 80
autocmd BufRead,BufNewFile todo.md set ft=taskpaper 
autocmd BufRead,BufNewFile todo.md set statusline=
autocmd BufWritePost todo.md call timer_start(1000, {-> execute("echo ''", "")})
autocmd TextChanged,TextChangedI todo.md silent write  
autocmd VimEnter todo.md  setlocal complete=k/~/notes/journal/**/*

autocmd BufRead,BufNewFile todo.md set ft=taskpaper 
autocmd BufRead,BufNewFile todo.md set statusline=
autocmd BufWritePost */journal/** call timer_start(1000, {-> execute("echo ''", "")})
autocmd TextChanged,TextChangedI */journal/** silent write  
autocmd VimEnter */journal/**  setlocal complete=k/~/notes/journal/**/*
augroup END
]])

_G.JournalMode = function()
  -- open journal file with date
  local fname =
    vim.fn.resolve(os.getenv("HOME") .. "/notes/journal/" .. os.date("%Y") .. "/" .. os.date("%d%b") .. ".md")
  local skeleton = vim.fn.resolve(os.getenv("HOME") .. "/notes/journal/" .. "journal.skeleton")
  vim.api.nvim_command("e " .. fname)
  vim.api.nvim_command("0r " .. skeleton)
  vim.api.nvim_command("set autowriteall")
  vim.api.nvim_command("set spell!")
end

_G.JournalDeserveMode = function()
  -- open journal file with date
  local fname =
    vim.fn.resolve(os.getenv("HOME") .. "/notes/deserve/" .. os.date("%Y") .. "/" .. os.date("%d%b") .. ".md")
  vim.api.nvim_command("e " .. fname)
  vim.api.nvim_command("set autowriteall")
  vim.api.nvim_command("set spell!")
end

_G.ScratchPad = function()
  -- open journal file with date
  local fname = vim.fn.resolve(os.getenv("HOME") .. "/" .. "scratch.md")
  vim.api.nvim_command("e " .. fname)
  vim.api.nvim_command("Goyo")
  vim.api.nvim_command("set autowriteall")
end

vim.api.nvim_set_keymap("n", "<leader>J", ":lua JournalMode()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>JD", ":lua JournalDeserveMode()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>je", ":!~/bin/send-journal %<CR>", { noremap = true })
vim.cmd([[ command! Journal execute 'lua JournalMode()' ]])
vim.cmd([[ command! Scratch execute 'lua ScratchPad()' ]])
vim.cmd([[ command! Deserve execute 'lua JournalDeserveMode()' ]])
