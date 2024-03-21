return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "javascript",
                    "jsdoc",
                    "lua",
                    "typescript",
                    "vimdoc",
                },

                sync_install = false,
                auto_install = true,

                indent = {
                    enable = true,
                },

                highlight = {
                    enable = true,
                },
            })
        end,
    },
    { "nvim-treesitter/nvim-treesitter-context" },
}
