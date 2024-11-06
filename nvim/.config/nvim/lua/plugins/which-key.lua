return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          mode = { "n", "v" },

          { "<leader>c", group = "code" },
          { "<leader>f", group = "files" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>n", group = "notes" },
          { "<leader>s", group = "search" },
          { "<leader>x", group = "diagnostics/quickfix" },

          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "z", group = "fold/spell" },

          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
      icons = {
        mappings = false,
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
  },
}
