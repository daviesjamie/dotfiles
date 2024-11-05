return {
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lsp_defaults = require("lspconfig").util.default_config

      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local map = require("utils").buffer_map(event.buf)

          map("n", "gd", vim.lsp.buf.definition, "Goto definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
          map("n", "gI", vim.lsp.buf.implementation, "Goto implementation")
          map("n", "gr", vim.lsp.buf.references, "Find references")
          map("n", "gy", vim.lsp.buf.type_definition, "Goto type definition")

          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
          map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>cc", vim.lsp.codelens.run, "Run codelens")
          map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh codelens")
          map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        },
      })
    end,
  },
}
