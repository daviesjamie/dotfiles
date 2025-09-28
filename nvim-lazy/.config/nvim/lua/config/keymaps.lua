vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank rest of line to system clipboard" })

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over without losing register contents" })

-- Make tab keybindings a bit easier to use
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.set("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Make snacks git log keybindings more memorable
vim.keymap.del("n", "<leader>gf")
vim.keymap.del("n", "<leader>gl")
vim.keymap.del("n", "<leader>gL")
vim.keymap.set("n", "<leader>gl", function()
  Snacks.picker.git_log_file()
end, { desc = "Git log (file)" })
vim.keymap.set("n", "<leader>gL", function()
  Snacks.picker.git_log({ cwd = LazyVim.root.git() })
end, { desc = "Git log (repo)" })

-- Disable snacks keybindings to copy/open web references
-- (using fugitive and rhubarb for this)
vim.keymap.del({ "n", "x" }, "<leader>gB")
vim.keymap.del({ "n", "x" }, "<leader>gY")

-- Disable snacks keybinding for git blame
-- (using gitsigns for this)
vim.keymap.del("n", "<leader>gb")
