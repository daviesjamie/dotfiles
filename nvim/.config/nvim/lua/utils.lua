local M = {}

M.augroup = function(name)
  return vim.api.nvim_create_augroup("jagd_" .. name, { clear = true })
end

M.buffer_map = function(buffer)
  return function(mode, keys, func, desc)
    local opts = { buffer = buffer }
    if desc then
      opts["desc"] = desc
    end
    vim.keymap.set(mode, keys, func, opts)
  end
end

M.map = function(mode, keys, func, desc)
  local opts = desc and { desc = desc } or {}
  vim.keymap.set(mode, keys, func, opts)
end

return M
