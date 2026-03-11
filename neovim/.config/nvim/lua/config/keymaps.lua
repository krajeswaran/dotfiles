-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- change some telescope options and a keymap to browse plugin files
vim.keymap.set("n", "<leader>n", function()
  Snacks.picker.files({ cwd = "~/notes" })
end, { desc = "Search notes" })

vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.smart()
end, { desc = "Smart picker" })

vim.keymap.set("n", "<leader>o", function()
  Snacks.picker.files()
end, { desc = "Project files" })

vim.keymap.set("n", "<leader>p", function()
  Snacks.picker.recent()
end, { desc = "Old files" })

vim.keymap.set("n", "<leader>k", function()
  Snacks.picker.help()
end, { desc = "Search help tags" })

vim.keymap.set("n", "z=", function()
  Snacks.picker.spelling()
end, { desc = "Spelling suggestions" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Open parent directory" })
