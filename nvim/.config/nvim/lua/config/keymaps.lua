local utils = require("utils")
local map = utils.map

map({ "n", "i" }, "<Esc>", "<cmd>nohlsearch<CR><Esc>", "Escape and clear hlsearch")

-- Make jumping with Ctrl D/U stay centred in screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Open folds and centre cursor when jumping between search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Make yanking/pasting to/from system clipboard a bit easier
map({ "n", "x" }, "<leader>y", [["+y]], "Yank to system clipboard")
map("n", "<leader>Y", [["+Y]], "Yank rest of line to system clipboard")
map({ "n", "x" }, "<leader>d", [["_d]], "Delete without losing register contents")

-- Never overwrite register contents when pasting over selection
map("x", "p", [["_dP]], "Paste over visual selection without losing register contents")

-- Stop accidentally pressing Q
map("n", "Q", "<nop>")

-- Quickly move lines up/down with <up> and <down>
map("n", "<up>", "<cmd>m .+1<CR>==", "Move line down")
map("n", "<down>", "<cmd>m .-2<CR>==", "Move line up")
map("v", "<up>", "<cmd>m '>+1<CR>gv=gv", "Move selection down")
map("v", "<down>", "<cmd>m '<-2<CR>gv=gv", "Move selection up")

-- Re-select selection after indenting in visual mode
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Buffer navigation
map("n", "[b", vim.cmd.bprevious, "Previous buffer")
map("n", "]b", vim.cmd.bnext, "Next buffer")
map("n", "<leader>bd", utils.buffer_delete, "Delete buffer")

-- Quickfix navigation
map("n", "<leader>xq", vim.cmd.cwindow, "Toggle quickfix window")
map("n", "[Q", vim.cmd.cfirst, "First quickfix entry")
map("n", "[q", vim.cmd.cprevious, "Previous quickfix entry")
map("n", "]q", vim.cmd.cnext, "Next quickfix entry")
map("n", "]Q", vim.cmd.clast, "Last quickfix entry")

-- Location list navigation
map("n", "<leader>xl", vim.cmd.lwindow, "Toggle location list window")
map("n", "[L", vim.cmd.lfirst, "First location list entry")
map("n", "[l", vim.cmd.lprevious, "Previous location list entry")
map("n", "]l", vim.cmd.lnext, "Next location list entry")
map("n", "]L", vim.cmd.llast, "Last location list entry")

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

-- Diagnostic navigation
map("n", "<leader>cd", vim.diagnostic.open_float, "Code diagnostic")
map("n", "]d", diagnostic_goto(true), "Next diagnostic")
map("n", "[d", diagnostic_goto(false), "Previous diagnostic")
map("n", "]e", diagnostic_goto(true, "ERROR"), "Next error")
map("n", "[e", diagnostic_goto(false, "ERROR"), "Previous error")
map("n", "]w", diagnostic_goto(true, "WARN"), "Next warning")
map("n", "[w", diagnostic_goto(false, "WARN"), "Previous warning")
