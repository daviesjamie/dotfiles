return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  config = function()
    local lsp_defaults = require("lspconfig").util.default_config

    lsp_defaults.capabilities =
      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local map = require("jagd.utils").buffer_map(event.buf)

        -- These are superseded by the Telescope equivalents
        -- map("n", "gd", vim.lsp.buf.definition, "Goto definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
        -- map("n", "gI", vim.lsp.buf.implementation, "Goto implementation")
        -- map("n", "gr", vim.lsp.buf.references, "Find references")
        -- map("n", "gy", vim.lsp.buf.type_definition, "Goto type definition")

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
}
