-- Keymaps are automatically loaded on the VeryLazy event

local map = function(mode, keys, func, desc)
  local opts = desc and { desc = desc } or {}
  vim.keymap.set(mode, keys, func, opts)
end

map({ "n", "i" }, "<Esc>", "<cmd>nohlsearch<CR><Esc>", "Escape and clear hlsearch")

-- Make jumping with Ctrl D/U stay centred in screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Open folds and centre cursor when jumping between search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Make yanking/pasting to/from system clipboard a bit easier
map({ "n", "x" }, "<leader>y", [["+y]], "[Y]ank to system clipboard")
map("n", "<leader>Y", [["+Y]], "[Y]ank rest of line to system clipboard")
map({ "n", "x" }, "<leader>d", [["_d]], "[D]elete without losing register contents")
map("x", "<leader>p", [["_dP]], "[P]aste over visual selection without losing register contents")

-- Stop accidentally pressing Q
map("n", "Q", "<nop>")

-- Quickly move lines up/down with Alt + j/k
map("n", "<A-j>", "<cmd>m .+1<CR>==", "Move line down")
map("n", "<A-k>", "<cmd>m .-2<CR>==", "Move line up")
map("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", "Move selection up")

-- Re-select selection after indenting in visual mode
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Buffer navigation
map("n", "[b", vim.cmd.bprevious, "Previous [B]uffer")
map("n", "]b", vim.cmd.bnext, "Next [B]uffer")
map("n", "<leader>bd", LazyVim.ui.bufremove, "[D]elete [B]uffer")

-- Quickfix navigation
map("n", "<leader>xq", vim.cmd.cwindow, "Toggle [Q]uickfix window")
map("n", "[Q", vim.cmd.cfirst, "First [Q]uickfix entry")
map("n", "[q", vim.cmd.cprevious, "Previous [Q]uickfix entry")
map("n", "]q", vim.cmd.cnext, "Next [Q]uickfix entry")
map("n", "]Q", vim.cmd.clast, "Last [Q]uickfix entry")

-- Location list navigation
map("n", "<leader>xl", vim.cmd.lwindow, "Toggle [L]ocation list window")
map("n", "[L", vim.cmd.lfirst, "First [L]ocation list entry")
map("n", "[l", vim.cmd.lprevious, "Previous [L]ocation list entry")
map("n", "]l", vim.cmd.lnext, "Next [L]ocation list entry")
map("n", "]L", vim.cmd.llast, "Last [L]ocation list entry")

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

-- Diagnostic navigation
map("n", "<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
map("n", "]d", diagnostic_goto(true), "Next [D]iagnostic")
map("n", "[d", diagnostic_goto(false), "Previous [D]iagnostic")
map("n", "]e", diagnostic_goto(true, "ERROR"), "Next [E]rror")
map("n", "[e", diagnostic_goto(false, "ERROR"), "Previous [E]rror")
map("n", "]w", diagnostic_goto(true, "WARN"), "Next [W]arning")
map("n", "[w", diagnostic_goto(false, "WARN"), "Previous [W]arning")

-- Code formatting
map({ "n", "v" }, "<leader>cf", function()
  LazyVim.format({ force = true })
end, "[C]ode [F]ormat")

-- Quick toggling of options using LazyVim's toggle() helper
-- Copied straight from LazyVim's default config
LazyVim.toggle.map("<leader>uf", LazyVim.toggle.format())
LazyVim.toggle.map("<leader>uF", LazyVim.toggle.format(true))
LazyVim.toggle.map("<leader>us", LazyVim.toggle("spell", { name = "Spelling" }))
LazyVim.toggle.map("<leader>uw", LazyVim.toggle("wrap", { name = "Wrap" }))
LazyVim.toggle.map("<leader>uL", LazyVim.toggle("relativenumber", { name = "Relative Number" }))
LazyVim.toggle.map("<leader>ud", LazyVim.toggle.diagnostics)
LazyVim.toggle.map("<leader>ul", LazyVim.toggle.number)
LazyVim.toggle.map(
  "<leader>uc",
  LazyVim.toggle("conceallevel", { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } })
)
LazyVim.toggle.map("<leader>uT", LazyVim.toggle.treesitter)
LazyVim.toggle.map("<leader>ub", LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" }))
if vim.lsp.inlay_hint then
  LazyVim.toggle.map("<leader>uh", LazyVim.toggle.inlay_hints)
end

-- The gross keybindings below are because I need my terminal emulator on Mac
-- OS to treat Option + char with the default Mac behaviour of producing
-- extra symbols, rather than actually passing Option through as Alt (because
-- Option + 3 is how you type '#' on an en_GB mac keyboard).

-- Therefore these keybindings are the equivalents to the Alt keybindings
-- above, but mapped using the characters produced by Mac OS when pressing
-- that keybinding, rather than mapping the Alt modifier directly.

-- ∆ = Option/Alt + j
-- ˚ = Option/Alt + k
map("n", "∆", "<cmd>m .+1<CR>==", "Move line down")
map("n", "˚", "<cmd>m .-2<CR>==", "Move line up")
map("v", "∆", "<cmd>m '>+1<CR>gv=gv", "Move selection down")
map("v", "˚", "<cmd>m '<-2<CR>gv=gv", "Move selection up")
