vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Save undo history to a file, but don't save swap or backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Use British spellings
vim.opt.spelllang = { "en_gb", "en" }

-- Treat camelCase as separate words for spelling purposes
vim.opt.spelloptions:append("camel")

-- Only allow mouse in normal and visual mode
vim.opt.mouse = "nv"

-- Scroll one vertical line at a time with the mouse
vim.opt.mousescroll = "ver:1,hor:4"

-- When closing a tab, go to the next most recently used tab
vim.opt.tabclose:append({ "uselast" })

-- Don't use the system clipboard for all yanks/pastes
-- (instead use <leader>y and <leader>Y bindings to yank to system clipboard)
vim.opt.clipboard = ""
