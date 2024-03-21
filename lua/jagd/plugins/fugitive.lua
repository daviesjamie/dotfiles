return {
    "tpope/vim-fugitive",
    config = function()
        require("jagd.keymaps").fugitive()
    end,
}
