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

-- Don't fold when opening a file
vim.opt.foldenable = false

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
vim.opt.spell = true
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
