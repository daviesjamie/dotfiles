-- Options are automatically loaded before lazy.nvim startup

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse in all modes
vim.opt.mouse = "a"

-- Use 4-space tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true

-- Automatically indent new lines
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

-- Don't wrap lines
vim.opt.wrap = false

-- Save undo history to a file, but don't save swap or backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Show some whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Don't highlight search matches, but do show matches whilst typing
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Preview substitutions live
vim.opt.inccommand = "nosplit"

-- Make scrolling work with screen lines
vim.opt.smoothscroll = true

-- Keep lines visible above/below cursor
vim.opt.scrolloff = 10

-- Keep columns visible before/after cursor
vim.opt.sidescrolloff = 8

-- Always leave a gap for signs in number gutter
vim.opt.signcolumn = "yes"

-- Make keys repeat faster
vim.opt.updatetime = 50

-- Decrease wait time between keys in mapped sequences
vim.opt.timeoutlen = 300

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Search ignoring case unless search contains uppercase characters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search results (cleared with <Esc> in normal mode)
vim.opt.hlsearch = true

-- Prefer splitting windows to the right and the bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use British spellings
vim.opt.spelllang = { "en_gb" }

vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Don't automatically format
  - "t" -- Don't auto-wrap text
  + "c" -- Auto-wrap comments to textwidth
  + "q" -- Allow comments to be formatted with `gq`
  - "o" -- Don't insert comment when `o` or `O` -ing on a comment
  + "r" -- But do continue a comment when hitting enter
  - "n" -- Recognise numbered lists when formatting
  + "j" -- Remove comment leaders when joining lines
  - "2" -- Don't allow paragraphs to have a different indent on first line

-- Wrap lines at nice breaking points
vim.opt.linebreak = true

-- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.conceallevel = 2

-- Show a popup menu for insert mode completions, even if there's only one,
-- and don't auto-select an option.
vim.opt.completeopt = "menu,menuone,noselect"

-- Maximum number of items to show in a popup menu
vim.opt.pumheight = 10

-- Use 24-bit colors in the terminal
vim.opt.termguicolors = true

-- Hide netrw banner
vim.g.netrw_banner = 0

------------------------------------------------------------------------------
-- LazyVim-specific options

-- LazyVim auto format
vim.g.autoformat = true

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "telescope"

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
vim.o.foldenable = false

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Use LazyVim's statuscolumn to allow toggling line numbers
vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]

-- Use LazyVim's formatexpr for the `gq` operator
vim.opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
