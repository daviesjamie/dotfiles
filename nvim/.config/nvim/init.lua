-------------------------------------------------------------------------------
-- OPTIONS
-------------------------------------------------------------------------------

-- Show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Use 4-space tabs by default
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true

-- Don't wrap
vim.opt.wrap = false

-- Save undo history, but not swap or backups
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- Only allow mouse in normal and visual modes
vim.opt.mouse = "nv"

-- Make mouse scrolling smoother
vim.opt.mousescroll = "ver:1,hor:4"

-- Confirm to save changes before closing buffer
vim.opt.confirm = true

-- Always leave a gap for signs in the number gutter
vim.opt.signcolumn = "yes"

-- Highlight the line the cursor is on
vim.opt.cursorline = true

-- Highlight search results (cleared with <Esc> in normal mode)
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Search ignoring case unless search contains uppercase characters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Prefer splitting windows to the right and the bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Use 24-bit colours in the terminal
vim.opt.termguicolors = true

-- Use British spellings
vim.opt.spelllang = { "en_gb" }

-- Show a popup menu with extra details for completions, even if there's only
-- one. Auto-select the first option, but don't insert anything until selected
vim.opt.completeopt = "menu,menuone,noinsert,popup,fuzzy"

-- Use single-line borders with rounded corners for floating windows
vim.opt.winborder = "rounded"

-- Limit height of pop-up menus (default is to use all available space)
vim.opt.pumheight = 15

-- Fold based on indentation
vim.opt.foldmethod = "indent"

-- Make sure all folds are open when opening a buffer
vim.opt.foldlevelstart = 99

-------------------------------------------------------------------------------
-- KEYMAPS
-------------------------------------------------------------------------------

local map = function(mode, keys, func, desc, opts)
  local desc_opts = desc and { desc = desc } or {}
  local other_opts = opts or {}
  local full_opts = vim.tbl_extend("force", desc_opts, other_opts)
  vim.keymap.set(mode, keys, func, full_opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Use Esc to clear hlsearch
map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>")

-- Make jumping with <C-d>/<C-u> stay centred in the screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Re-select selection after indenting in visual mode
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Make yanking to system clipboard easier
map({ "n", "x" }, "<leader>y", [["+y]], "Yank to system clipboard")
map("n", "<leader>Y", [["+Y]], "Yank rest of line to system clipboard")

-- Never overwrite register contents when pasting over selection
map("x", "p", [["_dP]], "Paste over without losing register contents")

-- Insert some helpful expansions
map("i", "<C-r><C-d>", "<C-r>=strftime('%F')<cr>", "Current date")
map("i", "<C-r><C-t>", "<C-r>=strftime('%T')<cr>", "Current time")
map("i", "<C-r><C-f>", "<C-r>=expand('%:t')<cr>", "Current filename")
map("i", "<C-r><C-p>", "<C-r>=expand('%:p')<cr>", "Current filepath")

-- Open folds and centre cursor when jumping between search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Override builtin diagnostic keymaps to versions that open the diagnostic
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Jump to the next diagnostic in the current buffer")
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Jump to the previous diagnostic in the current buffer")

-------------------------------------------------------------------------------
-- AUTOCMDS
-------------------------------------------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup("jagd_" .. name, { clear = true })
end

-- Only show cursorline in current split
local cursorline_augroup = augroup("cursorline")
autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursorline_augroup,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorline_augroup,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-------------------------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/tpope/vim-fugitive",

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})

-- Colourscheme
vim.cmd("colorscheme tokyonight-moon")

-- Treesitter: run :TSUpdate after every update
autocmd("PackChanged", {
  group = augroup("treesitter_pack_changed"),
  callback = function(ev)
    local name, active, kind = ev.data.spec.name, ev.data.active, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" and active then
      vim.cmd("TSUpdate")
    end
  end,
})

-- Treesitter: ensure parsers are installed
require("nvim-treesitter").install({
  "bash",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "jsonc",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "printf",
  "query",
  "regex",
  "scss",
  "sql",
  "toml",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
})

-- Treesitter: enable highlighting, folding and indenting
autocmd("FileType", {
  group = augroup("treesitter_filetype"),
  callback = function(ev)
    local filetype = ev.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.treesitter.start()
    end
  end,
})

-- Snacks
require("snacks").setup({
  gitbrowse = { enabled = true, notify = false },
  indent = { enabled = true },
  input = { enabled = true },
  scope = { enabled = true },
  words = { enabled = true },
  picker = {
    enabled = true,
    win = {
      input = {
        keys = {
          ["<C-x>"] = { "edit_split", mode = { "i", "n" } },
          ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          ["g."] = { "toggle_hidden" },
          ["gi"] = { "toggle_ignored" },
        },
      },
      list = {
        keys = {
          ["<C-x>"] = { "edit_split", mode = { "i", "n" } },
          ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          ["g."] = { "toggle_hidden" },
          ["gi"] = { "toggle_ignored" },
        },
      },
    },
  },
  scroll = {
    enabled = true,
    animate = { duration = { step = 10, total = 100 } },
  },
})

-- Snacks gitbrowse
local copy_to_clipboard = function(s) vim.fn.setreg("+", s) end
map({ "n", "v" }, "<leader>gll", function() Snacks.gitbrowse({ what = "permalink", open = copy_to_clipboard }) end, "Copy git permalink")
map({ "n", "v" }, "<leader>glL", function() Snacks.gitbrowse({ what = "permalink" }) end, "Open git permalink")
map({ "n", "v" }, "<leader>glf", function() Snacks.gitbrowse({ what = "file", open = copy_to_clipboard }) end, "Copy link to git file")
map({ "n", "v" }, "<leader>glF", function() Snacks.gitbrowse({ what = "file" }) end, "Open link to git file")
map("n", "<leader>glr", function() Snacks.gitbrowse({ what = "repo", open = copy_to_clipboard }) end, "Copy link to git repo")
map("n", "<leader>glR", function() Snacks.gitbrowse({ what = "repo" }) end, "Open link to git repo")
map("n", "<leader>glc", function() Snacks.gitbrowse({ what = "commit", open = copy_to_clipboard }) end, "Copy link to git commit")
map("n", "<leader>glC", function() Snacks.gitbrowse({ what = "commit" }) end, "Open link to git commit")

-- Snacks picker
map("n", "<C-p>", function() Snacks.picker.smart() end, "Smart find files")
map("n", "<leader>,", function() Snacks.picker.buffers() end, "Find buffer")
map("n", "<leader>:", function() Snacks.picker.command_history() end, "Search command history")
map("n", "<leader>/", function() Snacks.picker.grep() end, "Grep")
map("x", "<leader>/", function() Snacks.picker.grep_word({ live = true }) end, "Grep")
map("n", "<leader><space>", function() Snacks.picker.resume() end, "Resume last picker")
map("n", "<leader>ff", function() Snacks.picker.files() end, "Find files")
map("n", "<leader>fr", function() Snacks.picker.recent() end, "Recent files")
map("n", "<leader>sc", function() Snacks.picker.commands() end, "Search commands")
map("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, "Search diagnostics")
map("n", "<leader>sh", function() Snacks.picker.help() end, "Search help")
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, "Search keymaps")
map("n", "<leader>sm", function() Snacks.picker.man() end, "Search man pages")

-- LSP
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_enable = true,
  ensure_installed = { "lua_ls" },
})

autocmd("LspAttach", {
  group = augroup("lsp_completion"),
  callback = function(ev)
    local bufopts = { silent = true, buffer = ev.buf }
    map("n", "grr", function() Snacks.picker.lsp_references() end, "Go to references", bufopts)
    map("n", "grt", function() Snacks.picker.lsp_type_definitions() end, "Go to type definition", bufopts)
    map("n", "gri", function() Snacks.picker.lsp_implementations() end, "Go to implementation", bufopts)

    map("n", "grd", function() Snacks.picker.lsp_definitions() end, "Go to definition", bufopts)
    map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, "Search symbols (buffer)", bufopts)
    map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "Search symbols (workspace)", bufopts)

    map("i", "<C-space>", vim.lsp.completion.get, "Trigger completion", bufopts)

    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local methods = vim.lsp.protocol.Methods
    if client:supports_method(methods.textDocument_completion) then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Oil file explorer
require("oil").setup({
  keymaps = {
    ["<C-s>"] = false,
    ["<C-h>"] = false,
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
    ["gh"] = { "h", mode = "n" },
    ["gl"] = { "l", mode = "n" },
    ["h"] = { "actions.parent", mode = "n" },
    ["l"] = { "actions.select", mode = "n" },
	},
})
map("n", "-", "<cmd>Oil --preview<cr>", "Open parent directory")

-- Gitsigns
require("gitsigns").setup({
  attach_to_untracked = true,
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
})

-- Fugitive
map("n", "<leader>gs", "<cmd>Git<cr>", "Git status")
map("n", "<leader>gS", "<cmd>vertical Git<cr>", "Git status (vertical)")
autocmd("User", {
  group = augroup("fugitive_index_keymaps"),
  pattern = "FugitiveIndex",
  callback = function(ev)
    local bufopts = { buffer = ev.buf }
    map("n", "<leader>gp", "<cmd>Git push<cr>", "git push", bufopts)
    map("n", "<leader>gP", "<cmd>Git push --force-with-lease<cr>", "git push --force-with-lease", bufopts)
  end,
})

-- Diffview
require("diffview").setup({
  use_icons = false,
  keymaps = {
    view = {
			{ "n", "gq", "<cmd>DiffviewClose<cr>", "Close the Diffview" },
		},
    file_panel = {
			{ "n", "gq", "<cmd>DiffviewClose<cr>", "Close the Diffview" },
		},
    file_history_panel = {
			{ "n", "gq", "<cmd>DiffviewClose<cr>", "Close the Diffview" },
		},
	},
})
map("n", "<leader>gc", "<cmd>DiffviewFileHistory %<cr>", "Git commits (file)")
map("n", "<leader>gC", "<cmd>DiffviewFileHistory<cr>", "Git commits (branch)")
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", "Git diff (index)")
map("n", "<leader>gD", "<cmd>DiffviewOpen ", "Git diff (rev)")

-- Load local overrides if they exist
if(vim.fn.filereadable(vim.fn.expand("~/.nvimrc.local")) == 1) then
  vim.cmd("luafile " .. vim.fn.expand("~/.nvimrc.local"))
end
