-- Keymaps are automatically loaded on the VeryLazy event

local map = function(mode, keys, func, desc)
  local opts = desc and { desc = desc } or {}
  vim.keymap.set(mode, keys, func, opts)
end

map({ "n", "i" }, "<Esc>", "<cmd>nohlsearch<CR><Esc>", "Escape and clear hlsearch")

-- Make jumping with Ctrl D/U stay centered in screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Open folds when jumping between search results
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
map("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv")
map("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv")

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
map("n", "[d", diagnostic_goto(true), "Next [D]iagnostic")
map("n", "]d", diagnostic_goto(false), "Previous [D]iagnostic")
map("n", "[e", diagnostic_goto(true, "ERROR"), "Next [E]rror")
map("n", "]e", diagnostic_goto(false, "ERROR"), "Previous [E]rror")
map("n", "[w", diagnostic_goto(true, "WARN"), "Next [W]arning")
map("n", "]w", diagnostic_goto(false, "WARN"), "Previous [W]arning")

-- Code formatting
map({ "n", "v" }, "<leader>cf", function()
  LazyVim.format({ force = true })
end, "[C]ode [F]ormat")
