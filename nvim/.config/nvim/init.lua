-------------------------------------------------------------------------------
-- OPTIONS
-------------------------------------------------------------------------------

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Show relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Use 4-space tabs by default
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.shiftround = true

-- Don't wrap
vim.o.wrap = false

-- Save undo history, but not swap or backups
vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true

-- Only allow mouse in normal and visual modes
vim.o.mouse = "nv"

-- Make mouse scrolling smoother
vim.o.mousescroll = "ver:1,hor:4"

-- Confirm to save changes before closing buffer
vim.o.confirm = true

-- Always leave a gap for signs in the number gutter
vim.o.signcolumn = "yes"

-- Highlight the line the cursor is on
vim.o.cursorline = true

-- Display some whitespace characters explicitly
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Highlight search results (cleared with <Esc> in normal mode)
vim.o.hlsearch = true
vim.o.incsearch = true

-- Search ignoring case unless search contains uppercase characters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Prefer splitting windows to the right and the bottom
vim.o.splitright = true
vim.o.splitbelow = true

-- Use 24-bit colours in the terminal
vim.o.termguicolors = true

-- Use British spellings
vim.opt.spelllang = { "en_gb" }

-- Show a popup menu with extra details for completions, even if there's only
-- one. Auto-select the first option, but don't insert anything until selected
vim.o.completeopt = "menu,menuone,noinsert,popup,fuzzy"

-- Use single-line borders with rounded corners for floating windows
vim.o.winborder = "rounded"

-- Limit height of pop-up menus (default is to use all available space)
vim.o.pumheight = 15

-- Fold based on indentation
vim.o.foldmethod = "indent"

-- Make sure all folds are open when opening a buffer
vim.o.foldlevelstart = 99

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Don't show text at the end of the line
  virtual_text = false,

  -- Don't show text underneath the line
  virtual_lines = false,

  -- Auto open the float, so you can easily read the errors when jumping
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_floater {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

-------------------------------------------------------------------------------
-- KEYMAPS
-------------------------------------------------------------------------------

local map = function(mode, keys, func, desc, opts)
  local desc_opts = desc and { desc = desc } or {}
  local other_opts = opts or {}
  local full_opts = vim.tbl_extend("force", desc_opts, other_opts)
  vim.keymap.set(mode, keys, func, full_opts)
end

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

-- Show list of diagnostics
map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic list")

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

-- Colour scheme
vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })
vim.cmd("colorscheme tokyonight-moon")

-- Guess the indent
vim.pack.add({ "https://github.com/NMAC427/guess-indent.nvim" })
require("guess-indent").setup({})

-- Gitsigns
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
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
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, "Jump to the next git change", { buf = bufnr })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, "Jump to the previous git change", { buf = bufnr })

    map("n", "<leader>ghp", gitsigns.preview_hunk, "git preview hunk", { buf = bufnr })
    map("n", "<leader>ghi", gitsigns.preview_hunk_inline, "git preview hunk inline", { buf = bufnr })
    map("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end, "git blame line", { buf = bufnr })
  end,
})

-- Fugitive
vim.pack.add({ "https://github.com/tpope/vim-fugitive" })
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

-- Surround keymaps
vim.pack.add({ "https://github.com/kylechui/nvim-surround" })
require("nvim-surround").setup({})

-- Oil file explorer
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
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
    ["-"] = { "actions.close", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["<Esc>"] = { "actions.close", mode = "n" },
  },
})
map("n", "-", "<cmd>Oil --float --preview<cr>", "Open parent directory")

-- Snacks
vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
  gitbrowse = { enabled = true, notify = false }, -- git links
  indent = { enabled = true }, -- indent guides
  input = { enabled = true }, -- better vim.ui.input windows
  scope = { enabled = true }, -- scope detection
  scratch = { enabled = true }, -- scratch buffers
  words = { enabled = true }, -- highlight LSP ref under cursor
  picker = { -- fuzzy finder
    enabled = true,
    icons = {
      files = { enabled = false },
      git = { enabled = false },
    },
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
})

-- Snacks - copy/open git links
local copy_to_clipboard = function(s) vim.fn.setreg("+", s) end
map({ "n", "v" }, "<leader>gww", function() Snacks.gitbrowse({ what = "permalink", open = copy_to_clipboard }) end, "Copy git permalink")
map({ "n", "v" }, "<leader>gwL", function() Snacks.gitbrowse({ what = "permalink" }) end, "Open git permalink")
map({ "n", "v" }, "<leader>gwf", function() Snacks.gitbrowse({ what = "file", open = copy_to_clipboard }) end, "Copy link to git file")
map({ "n", "v" }, "<leader>gwF", function() Snacks.gitbrowse({ what = "file" }) end, "Open link to git file")
map("n", "<leader>gwr", function() Snacks.gitbrowse({ what = "repo", open = copy_to_clipboard }) end, "Copy link to git repo")
map("n", "<leader>gwR", function() Snacks.gitbrowse({ what = "repo" }) end, "Open link to git repo")
map("n", "<leader>gwc", function() Snacks.gitbrowse({ what = "commit", open = copy_to_clipboard }) end, "Copy link to git commit")
map("n", "<leader>gwC", function() Snacks.gitbrowse({ what = "commit" }) end, "Open link to git commit")

-- Snacks - scratch buffer
map("n", "<leader>.", function() Snacks.scratch() end, "Toggle scratch buffer")
map("n", "<leader>S", function() Snacks.scratch.select() end, "Select scratch buffer")

-- Snacks - picker
map("n", "<C-p>", function() Snacks.picker.smart({ filter = { cwd = true } }) end, "Smart find files")
map("n", "<leader>,", function() Snacks.picker.buffers() end, "Find buffer")
map("n", "<leader>:", function() Snacks.picker.command_history() end, "Search command history")
map("n", "<leader>/", function() Snacks.picker.grep() end, "Grep")
map("x", "<leader>/", function() Snacks.picker.grep_word({ live = true }) end, "Grep")
map("n", "<leader><space>", function() Snacks.picker.resume() end, "Resume last picker")
map("n", "<leader>ff", function() Snacks.picker.files() end, "Find files")
map("n", "<leader>fr", function() Snacks.picker.recent({ filter = { cwd = true } }) end, "Recent files")
map("n", "<leader>sc", function() Snacks.picker.commands() end, "Search commands")
map("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, "Search diagnostics")
map("n", "<leader>sh", function() Snacks.picker.help() end, "Search help")
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, "Search keymaps")
map("n", "<leader>sm", function() Snacks.picker.man() end, "Search man pages")

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_enable = true,
  ensure_installed = { "lua_ls" },
})

autocmd("LspAttach", {
  group = augroup("lsp_attach"),
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

-------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------

-- Run :TSUpdate after every update
autocmd("PackChanged", {
  group = augroup("treesitter_pack_changed"),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })

-- Ensure parsers are installed
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

-- Enable highlighting, folding and indenting
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

-------------------------------------------------------------------------------
-- Local config
-------------------------------------------------------------------------------

-- Load local overrides if they exist
if(vim.fn.filereadable(vim.fn.expand("~/.nvimrc.local")) == 1) then
  vim.cmd("luafile " .. vim.fn.expand("~/.nvimrc.local"))
end
