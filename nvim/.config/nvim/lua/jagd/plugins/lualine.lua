return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      section_separators = "",
      component_separators = "┃",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "%f" },

      lualine_x = {
        { "diagnostics" },
        {
          function()
            return "  " .. require("dap").status()
          end,
          cond = function()
            return package.loaded["dap"] and require("dap").status() ~= ""
          end,
        },
      },
      lualine_y = { "filetype" },
      lualine_z = { "location" },
    },
    extensions = { "fugitive", "lazy" },
  },
}
