local prettier_filetypes = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "Format", "FormatDisable", "FormatEnable" },
  keys = {
    { "<leader>f", "<cmd>Format<cr>", mode = "n", desc = "Format buffer" },
    { "<leader>f", "<cmd>Format<cr>", mode = "v", desc = "Format selection" },
  },
  opts = function()
    local opts = {
      default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 3000,
      },
      format_on_save = function(bufnr)
        -- Allow disabling autoformat with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "pg_format" },
      },
    }

    for _, ft in ipairs(prettier_filetypes) do
      opts.formatters_by_ft[ft] = { "prettierd", "prettier", stop_after_first = true }
    end

    return opts
  end,
  init = function()
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })

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
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}