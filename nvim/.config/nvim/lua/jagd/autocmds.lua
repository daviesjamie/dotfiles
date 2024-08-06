local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
    return vim.api.nvim_create_augroup("jagd_" .. name, { clear = true })
end

-- Only show cursor line in current split
local cursorline_group = augroup("cursorline")
autocmd("WinLeave", {
    group = cursorline_group,
    command = "set nocursorline",
})
autocmd("WinEnter", {
    group = cursorline_group,
    command = "set cursorline",
})

-- Briefly highlight yanked range
autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    group = augroup("trailing_whitespace"),
    command = [[%s/\s\+$//e]],
})

-- Check if files need to be reloaded after an external change
autocmd("FocusGained", {
    group = augroup("reload_files"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Turn on spell-checking in some filetypes
autocmd("FileType", {
    group = augroup("spelling"),
    pattern = { "text", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

-- Auto-create directory structure when writing a file
autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
