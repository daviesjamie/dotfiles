return {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
        require("which-key").register({
            ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
            ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
            ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
            ["<leader>p"] = { name = "[P]roject", _ = "which_key_ignore" },
            ["<leader>v"] = { name = "Neo[V]im", _ = "which_key_ignore" },
        })
    end,
}
