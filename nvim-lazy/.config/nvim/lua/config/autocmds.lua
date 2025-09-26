-- Only show cursor line in active window, and not in insert mode
local auto_cursorline_group = vim.api.nvim_create_augroup("jagd_auto_cursorline", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = auto_cursorline_group,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = auto_cursorline_group,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- Add some extra filetypes that can be closed with `q`
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_close_with_q", { clear = false }),
  pattern = { "fugitive", "minifiles" },
  callback = function(event)
    local lazyvim_close_callback = vim.api.nvim_get_autocmds({ group = "lazyvim_close_with_q" })[1].callback
    if lazyvim_close_callback then
      lazyvim_close_callback(event)
    end
  end,
})
