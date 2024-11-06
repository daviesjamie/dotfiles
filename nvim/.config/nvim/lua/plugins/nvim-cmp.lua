return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "f3fora/cmp-spell",
    "folke/lazydev.nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "nvim-treesitter/nvim-treesitter",
    "ray-x/cmp-treesitter",
  },
  event = "InsertEnter",
  opts = function()
    local cmp = require("cmp")
    local context = require("cmp.config.context")

    local disabled_buftype = function()
      local disabled = {
        nofile = true,
        prompt = true,
      }
      return disabled[vim.bo.buftype] or false
    end

    local in_comment = function()
      return context.in_treesitter_capture("comment") or context.in_syntax_group("Comment")
    end

    local in_spell = function()
      return context.in_treesitter_capture("spell")
    end

    return {
      enabled = function()
        return not in_comment() and not disabled_buftype()
      end,
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "lazydev" },
      }, {
        { name = "spell", option = { enable_in_context = in_spell } },
      }, {
        { name = "treesitter", keyword_length = 3 },
        { name = "path" },
        { name = "calc" },
      }, {
        { name = "buffer", keyword_length = 3 },
      }),
      mapping = {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
          { "i", "c" }
        ),
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
    }
  end,
}
