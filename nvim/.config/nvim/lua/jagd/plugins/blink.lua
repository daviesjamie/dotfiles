return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    completion = {
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
      menu = {
        border = "rounded",
      },
    },
    keymap = { preset = "default" },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
    sources = {
      default = { "lsp", "path", "snippets" },
    },
  },
}
