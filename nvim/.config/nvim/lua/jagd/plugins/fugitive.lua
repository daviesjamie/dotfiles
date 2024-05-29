local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

            local jagd_fugitive_group = augroup("jagd_fugitive", { clear = true })
            autocmd("BufWinEnter", {
                group = jagd_fugitive_group,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()

                    vim.keymap.set("n", "<leader>gp", function()
                        vim.cmd.Git("push")
                    end, {
                        buffer = bufnr,
                        remap = false,
                        desc = "[G]it [P]ush",
                    })

                    vim.keymap.set("n", "<leader>gP", function()
                        vim.cmd.Git("push --force-with-lease")
                    end, {
                        buffer = bufnr,
                        remap = false,
                        desc = "[G]it [P]ush --force",
                    })

                    vim.keymap.set("n", "<leader>gu", function()
                        vim.cmd.Git("pull --rebase")
                    end, { buffer = bufnr, remap = false, desc = "Git P[u]ll --rebase" })

                    vim.keymap.set({ "n", "x" }, "<leader>gw", function()
                        vim.cmd(":GBrowse<CR>")
                    end, {
                        buffer = bufnr,
                        remap = false,
                        desc = "Open line/selection in [G]it [W]eb UI",
                    })

                    vim.keymap.set({ "n", "x" }, "<leader>gW", function()
                        vim.cmd(":GBrowse!<CR>")
                    end, {
                        buffer = bufnr,
                        remap = false,
                        desc = "Copy URL to line/selection in [G]it [W]eb UI",
                    })
                end,
            })
        end,
    },
    { "shumphrey/fugitive-gitlab.vim" },
}
