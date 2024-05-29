return {
    "echasnovski/mini.nvim",
    config = function()
        -- Better around/inside text objects
        require("mini.ai").setup({ n_lines = 500 })

        -- Align text with `ga` or `gA`
        require("mini.align").setup()

        -- Add some vim-unimpaired-style keybindings
        -- stylua: ignore
        require("mini.bracketed").setup({
            buffer     = { suffix = "b" },
            comment    = { suffix = "c" },
            conflict   = { suffix = "x" },
            diagnostic = { suffix = "d" },
            file       = { suffix = "f" },
            indent     = { suffix = "i" },
            jump       = { suffix = "" },
            location   = { suffix = "l" },
            oldfile    = { suffix = "o" },
            quickfix   = { suffix = "q" },
            treesitter = { suffix = "t" },
            undo       = { suffix = "" },
            window     = { suffix = "" },
            yank       = { suffix = "" },
        })

        -- Add/delete/replace text surroundings
        require("mini.surround").setup()
    end,
}
