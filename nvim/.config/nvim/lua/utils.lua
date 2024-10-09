local M = {}

M.map = function(mode, keys, func, desc)
  local opts = desc and { desc = desc } or {}
  vim.keymap.set(mode, keys, func, opts)
end

return M
