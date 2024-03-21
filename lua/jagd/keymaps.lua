vim.g.mapleader = " "

vim.keymap.set(
    "n",
    "<leader>pv",
    vim.cmd.Ex,
    { desc = "Project View: Open Netrw" }
)

-- Make jumping with Ctrl D/U stay centered in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Open folds when jumping between seach results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Make yanking/pasting to/from system clipboard a bit easier
vim.keymap.set(
    { "n", "v" },
    "<leader>y",
    [["+y]],
    { desc = "Copy to system clipboard" }
)

vim.keymap.set(
    "n",
    "<leader>Y",
    [["+Y]],
    { desc = "Copy rest of line to system clipboard" }
)

vim.keymap.set(
    "x",
    "<leader>p",
    [["_dP]],
    { desc = "Paste over visual selection without losing register contents" }
)

-- Stop accidentally pressing Q
vim.keymap.set("n", "Q", "<nop>")

-- Quickly move visual selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Re-select selection after indenting in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
