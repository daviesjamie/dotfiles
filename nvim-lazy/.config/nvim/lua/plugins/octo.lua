return {
  {
    "pwntester/octo.nvim",
    opts = {
      use_local_fs = true,
    },
    keys = {
      { "<leader>gi", false },
      { "<leader>gI", false },
      { "<leader>gp", false },
      { "<leader>gP", false },
      { "<leader>gr", false },
      { "<leader>gS", false },

      { "<leader>gri", "<cmd>Octo issue list<CR>", desc = "List issues" },
      { "<leader>grI", "<cmd>Octo issue search<CR>", desc = "Search issues" },
      { "<leader>grp", "<cmd>Octo pr list<CR>", desc = "List PRs" },
      { "<leader>grP", "<cmd>Octo pr search<CR>", desc = "Search PRs" },
      { "<leader>grr", "<cmd>Octo repo list<CR>", desc = "List repos" },
      { "<leader>gr/", "<cmd>Octo search<CR>", desc = "Search" },
    },
  },
}
