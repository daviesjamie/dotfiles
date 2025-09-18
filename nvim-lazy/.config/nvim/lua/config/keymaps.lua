vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank rest of line to system clipboard" })

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over without losing register contents" })

vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.set("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
