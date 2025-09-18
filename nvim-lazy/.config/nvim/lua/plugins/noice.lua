return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      view = "cmdline",
      format = {
        cmdline = false,
        search_down = false,
        search_up = false,
        filter = false,
        lua = false,
        help = false,
        input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
      },
    },
  },
}
