return {
  "nvim-mini/mini.files",
  opts = {
    options = {
      use_as_default_explorer = true,
    },
    mappings = {
      close = "<Esc>",
      go_in = "L",
      go_in_plus = "l",
      go_in_horizontal = "g<C-x>",
      go_in_horizontal_plus = "<C-x>",
      go_in_vertical = "g<C-v>",
      go_in_vertical_plus = "<C-v>",
      go_out = "H",
      go_out_plus = "h",
    },
  },
  keys = {
    { "<leader>fm", false },
    { "<leader>fM", false },
    {
      "-",
      function()
        if not require("mini.files").close() then
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end
      end,
      desc = "Open mini.files (Directory of Current File)",
    },
    {
      "_",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
}
