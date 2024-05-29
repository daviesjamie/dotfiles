return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        require("telescope").setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        })

        pcall(require("telescope").load_extension, "ui-select")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Project git-tracked files" })

        vim.keymap.set("n", "<leader>/", builtin.resume, { desc = "Resume last telescope search" })

        vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "[G]it [B]ranches" })
        vim.keymap.set("x", "<leader>gc", builtin.git_bcommits_range, { desc = "[G]it [C]ommits for lines" })
        vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "[G]it [C]ommits for buffer" })
        vim.keymap.set("n", "<leader>gC", builtin.git_commits, { desc = "All [G]it [C]ommits" })

        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]iles" })
        vim.keymap.set("n", "<leader>pr", builtin.oldfiles, { desc = "[P]roject [R]ecent files" })
        vim.keymap.set("n", "<leader>p/", builtin.live_grep, { desc = "[P]roject search ([/])" })
        vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "[P]roject [D]iagnostics" })

        vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Search Neo[V]im [H]elp tags" })
        vim.keymap.set("n", "<leader>vk", builtin.keymaps, { desc = "Search Neo[V]im [K]eymaps" })
        vim.keymap.set("n", "<leader>v/", function()
            builtin.live_grep({ cwd = vim.fn.stdpath("config") })
        end, { desc = "Search Neo[V]im config files ([/])" })
    end,
}
