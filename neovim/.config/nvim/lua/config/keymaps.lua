-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- change some telescope options and a keymap to browse plugin files
vim.keymap.set("n", "<leader>n", function()
  require("fzf-lua").files({ cwd = "~/notes" })
end, { desc = "Search notes" })

vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.smart()
end, { desc = "Smart picker" })

vim.keymap.set("n", "<leader>o", function()
  require("fzf-lua").files()
end, { desc = "Project files" })

vim.keymap.set("n", "<leader>p", function()
  require("fzf-lua").oldfiles()
end, { desc = "Old files" })

vim.keymap.set("n", "<leader>k", function()
  require("fzf-lua").helptags()
end, { desc = "Search help tags" })

vim.keymap.set("n", "z=", function()
  require("fzf-lua").spell_suggest()
end, { desc = "Spelling suggestions" })
