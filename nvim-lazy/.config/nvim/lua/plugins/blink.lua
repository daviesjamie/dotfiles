return {
  "saghen/blink.cmp",
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "markdown", "text" }, vim.bo.filetype)
    end,
    keymap = {
      preset = "default",
    },
  },
}
