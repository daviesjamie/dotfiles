local M = {}

M.augroup = function(name)
  return vim.api.nvim_create_augroup("jagd_" .. name, { clear = true })
end

-- Shamelessly stolen from LazyVim
M.buffer_delete = function(buffer)
  buffer = buffer or 0
  buffer = buffer == 0 and vim.api.nvim_get_current_buf() or buffer

  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 0 or choice == 3 then
      return
    end
    if choice == 1 then
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buffer)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buffer then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr("#")
      if alt ~= buffer and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buffer ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buffer) then
    pcall(vim.cmd, "bdelete! " .. buffer)
  end
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
