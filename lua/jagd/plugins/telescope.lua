return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({})
        local builtin = require("telescope.builtin")

        vim.keymap.set(
            "n",
            "<C-p>",
            builtin.find_files,
            { desc = "Fuzzy find files" }
        )
        vim.keymap.set(
            "n",
            "<leader>pf",
            builtin.find_files,
            { desc = "Project Find: fuzzy find files" }
        )

        vim.keymap.set(
            "n",
            "<leader>ps",
            builtin.live_grep,
            { desc = "Project Search: search project for string" }
        )
        vim.keymap.set(
            "n",
            "<leader>p/",
            builtin.live_grep,
            { desc = "Project Search: search project for string" }
        )

        vim.keymap.set("n", "<leader>pw", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Project Word: search project for word" })

        vim.keymap.set("n", "<leader>pW", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Project WORD: search project for WORD" })
    end,
}
