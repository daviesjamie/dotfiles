return {
  "nanozuki/tabby.nvim",
  event = "VeryLazy",
  opts = {
    preset = "tab_only",
    option = {
      tab_name = {
        name_fallback = function(tabid)
          -- Assume the first tab (i.e. the one created at start-up) is the root
          return tabid == 1 and "root" or tabid
        end,
      },
    },
  },
}
