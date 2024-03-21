return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({})
        local builtin = require("telescope.builtin")
        require("jagd.keymaps").telescope(builtin)
    end,
}
