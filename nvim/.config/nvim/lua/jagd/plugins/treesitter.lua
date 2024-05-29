return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "jsdoc",
                "lua",
                "luadoc",
                "markdown",
                "typescript",
                "vim",
                "vimdoc",
            },

            auto_install = true,
            sync_install = false,

            highlight = { enable = true },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = { max_lines = 5 },
    },
}
