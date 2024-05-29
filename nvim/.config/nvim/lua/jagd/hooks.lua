local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Only show cursor line in current split
local cursorline_group = augroup("jagd_cursorline", { clear = true })
autocmd("WinLeave", {
    group = cursorline_group,
    pattern = "*",
    command = "set nocursorline",
})
autocmd("WinEnter", {
    group = cursorline_group,
    pattern = "*",
    command = "set cursorline",
})

-- Briefly highlight yanked range
local yank_group = augroup("jagd_highlight_yank", { clear = true })
autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remove trailing whitespace on save
local whitespace_group = augroup("jagd_trailing_whitespace", { clear = true })
autocmd("BufWritePre", {
    group = whitespace_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
