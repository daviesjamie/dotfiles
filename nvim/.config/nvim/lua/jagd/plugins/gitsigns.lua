return {
    "lewis6991/gitsigns.nvim",
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]h", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, { desc = "Jump to next git [H]unk" })

            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[h", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, { desc = "Jump to previous git [H]unk" })

            map("v", "<leader>hs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Git [H]unk [S]tage" })
            map("v", "<leader>hr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Git [H]unk [R]eset" })

            map("n", "<leader>g?", gitsigns.blame_line, { desc = "[G]it [b]lame line" })
            map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git [H]unk [S]tage" })
            map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git [H]unk [R]eset" })
            map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git [H]unk [U]ndo stage" })
            map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git [H]unk [P]review" })
            map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git [H]unk [D]iff against index" })
            map("n", "<leader>hD", function()
                gitsigns.diffthis("@")
            end, { desc = "Git [H]unk [D]iff against last commit" })
        end,
    },
}
