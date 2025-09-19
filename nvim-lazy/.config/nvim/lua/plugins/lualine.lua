return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      section_separators = "",
      component_separators = "┃",
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        "branch",
      },
      lualine_c = {
        { LazyVim.lualine.pretty_path({ length = 6, modified_sign = "+" }), separator = "", padding = 1 },
        { "navic", color_correction = "dynamic", separator = "", padding = 0 },
      },
      lualine_x = {
        {
          function()
            return "  " .. require("dap").status()
          end,
          cond = function()
            return package.loaded["dap"] and require("dap").status() ~= ""
          end,
          color = function()
            return { fg = Snacks.util.color("Debug") }
          end,
        },
        {
          "diagnostics",
          symbols = {
            error = LazyVim.config.icons.diagnostics.Error,
            warn = LazyVim.config.icons.diagnostics.Warn,
            info = LazyVim.config.icons.diagnostics.Info,
            hint = LazyVim.config.icons.diagnostics.Hint,
          },
        },
        {
          "diff",
          symbols = {
            added = "+",
            modified = "~",
            removed = "-",
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_y = {
        { "filetype", icons_enabled = false, padding = { left = 1, right = 1 } },
      },
      lualine_z = {
        { "location" },
      },
    },
  },
}
