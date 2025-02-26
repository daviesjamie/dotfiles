return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "Format buffer/selection",
    },
  },
  config = function()
    require("conform").setup({
      default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 3000,
      },
      format_on_save = function(bufnr)
        -- Allow disabling autoformat with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return { timeout_ms = 1000 }
      end,
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
      -- stylua: ignore
      formatters_by_ft = {
        lua = { "stylua" },
        sh  = { "shfmt" },
        sql = { "pg_format" },

        css              = {"prettierd", "prettier", stop_after_first = true},
        graphql          = {"prettierd", "prettier", stop_after_first = true},
        handlebars       = {"prettierd", "prettier", stop_after_first = true},
        html             = {"prettierd", "prettier", stop_after_first = true},
        javascript       = {"prettierd", "prettier", stop_after_first = true},
        javascriptreact  = {"prettierd", "prettier", stop_after_first = true},
        json             = {"prettierd", "prettier", stop_after_first = true},
        jsonc            = {"prettierd", "prettier", stop_after_first = true},
        less             = {"prettierd", "prettier", stop_after_first = true},
        markdown         = {"prettierd", "prettier", stop_after_first = true},
        ["markdown.mdx"] = {"prettierd", "prettier", stop_after_first = true},
        scss             = {"prettierd", "prettier", stop_after_first = true},
        typescript       = {"prettierd", "prettier", stop_after_first = true},
        typescriptreact  = {"prettierd", "prettier", stop_after_first = true},
        vue              = {"prettierd", "prettier", stop_after_first = true},
        yaml             = {"prettierd", "prettier", stop_after_first = true},
      },
    })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      -- :FormatDisable will disable autoformatting in the local buffer,
      -- whilst :FormatDisable! will disable it globally
      if args.bang then
        vim.g.disable_autoformat = true
      else
        vim.b.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
