vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project View: Open Netrw" })

-- Make jumping with Ctrl D/U stay centered in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project View: Open Netrw" })

-- Open folds when jumping between seach results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Make yanking/pasting to/from system clipboard a bit easier
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })

vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy rest of line to system clipboard" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over visual selection without losing register contents" })

-- Stop accidentally pressing Q
vim.keymap.set("n", "Q", "<nop>")

-- Quickly move visual selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Re-select selection after indenting in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- vim-unimparied: arglist
vim.keymap.set("n", "[a", function()
    vim.cmd("silent! " .. vim.v.count1 .. "previous")
end, { desc = "Jump to [count] previous file in arglist" })
vim.keymap.set("n", "]a", function()
    vim.cmd("silent! " .. vim.v.count1 .. "next")
end, { desc = "Jump to [count] next file in arglist" })
vim.keymap.set("n", "[A", function()
    vim.cmd("first")
end, { desc = "Jump to first file in arglist" })
vim.keymap.set("n", "]A", function()
    vim.cmd("last")
end, { desc = "Jump to last file in arglist" })

-- vim-unimpaired: buffers
vim.keymap.set("n", "[b", function()
    vim.cmd(vim.v.count1 .. "bprevious")
end, { desc = "Jump to [count] previous buffer" })
vim.keymap.set("n", "]b", function()
    vim.cmd(vim.v.count1 .. "bnext")
end, { desc = "Jump to [count] next buffer" })
vim.keymap.set("n", "[B", function()
    vim.cmd("bfirst")
end, { desc = "Jump to first buffer" })
vim.keymap.set("n", "]B", function()
    vim.cmd("blast")
end, { desc = "Jump to last buffer" })

-- vim-unimpaired: loclist
vim.keymap.set("n", "[l", function()
    vim.cmd("silent! " .. vim.v.count1 .. "lprevious")
end, { desc = "Jump to [count] previous entry in loclist" })
vim.keymap.set("n", "]l", function()
    vim.cmd("silent! " .. vim.v.count1 .. "lnext")
end, { desc = "Jump to [count] next entry in loclist" })
vim.keymap.set("n", "[L", function()
    vim.cmd("lfirst")
end, { desc = "Jump to first entry in loclist" })
vim.keymap.set("n", "]L", function()
    vim.cmd("llast")
end, { desc = "Jump to last entry in loclist" })

-- vim-unimpaired: quickfix
vim.keymap.set("n", "[q", function()
    vim.cmd("silent! " .. vim.v.count1 .. "cprevious")
end, { desc = "Jump to [count] previous entry in quickfix list" })
vim.keymap.set("n", "]q", function()
    vim.cmd("silent! " .. vim.v.count1 .. "cnext")
end, { desc = "Jump to [count] next entry in quickfix list" })
vim.keymap.set("n", "[Q", function()
    vim.cmd("cfirst")
end, { desc = "Jump to first entry in quickfix list" })
vim.keymap.set("n", "]Q", function()
    vim.cmd("clast")
end, { desc = "Jump to last entry in quickfix list" })
