local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

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
                        desc = "Git Push",
                    })

                    vim.keymap.set("n", "<leader>gP", function()
                        vim.cmd.Git("push --force-with-lease")
                    end, {
                        buffer = bufnr,
                        remap = false,
                        desc = "Git Push --force",
                    })

                    vim.keymap.set("n", "<leader>gu", function()
                        vim.cmd.Git("pull --rebase")
                    end, { buffer = bufnr, remap = false, desc = "Git Pull --rebase" })

                    vim.keymap.set({ "n", "v" }, "<leader>gb", function()
                        vim.cmd(":GBrowse<CR>")
                    end, {
                        buffer = bufnr,
                        remap = false,
                        desc = "Git Browse: Open line/selection in web UI",
                    })

                    vim.keymap.set({ "n", "v" }, "<leader>gB", function()
                        vim.cmd(":GBrowse!<CR>")
                    end, {
                        buffer = bufnr,
                        remap = false,
                        desc = "Git Browse: Copy URL to line/selection in web UI",
                    })
                end,
            })
        end,
    },
    { "shumphrey/fugitive-gitlab.vim" },
}
