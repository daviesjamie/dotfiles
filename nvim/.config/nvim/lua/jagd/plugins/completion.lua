return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        {
            "kirasok/cmp-hledger",
            lazy = true,
            ft = "ledger",
        },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            mapping = cmp.mapping.preset.insert({
                -- Select [n]ext/[p]revious suggestion
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [f]orwards/[b]ackwards
                ["<C-f>"] = cmp.mapping.scroll_docs(-4),
                ["<C-b>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the suggestion
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                -- Manually trigger a completion
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- Move to the next/previous expansion locations
                -- [h] is left/back, [l] is right/next
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            }),
            sources = {
                { name = "hledger" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
            },
        })
    end,
}
