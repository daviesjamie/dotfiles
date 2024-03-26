return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- vim-unimpaired-style change navigation
                vim.keymap.set("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { buffer = bufnr, expr = true, desc = "Jump to next git change" })

                vim.keymap.set("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { buffer = bufnr, expr = true, desc = "Jump to previous git change" })

                -- actions
                vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Git: Reset hunk" })
                vim.keymap.set("v", "<leader>gr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { buffer = bufnr, desc = "Git: Reset hunk" })
                vim.keymap.set("n", "<leader>gd", gs.preview_hunk, { buffer = bufnr, desc = "Git: hunk Diff" })
                vim.keymap.set("n", "<leader>gb", function()
                    gs.blame_link({ full = true })
                end, { buffer = bufnr, desc = "Git: show Blame" })
            end,
        })
    end,
}
