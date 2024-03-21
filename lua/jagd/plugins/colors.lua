return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                highlight_groups = {
                    ExtraWhitespace = { bg = "love", blend = 75 },
                },
            })

            vim.cmd.colorscheme("rose-pine")
        end,
    },
}
