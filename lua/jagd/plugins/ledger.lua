return {
    "ledger/vim-ledger",
    lazy = true,
    ft = "ledger",
    config = function()
        vim.g.ledger_bin = "hledger"
        vim.g.ledger_extra_options = "--strict"

        vim.g.ledger_fold_blanks = 1

        vim.g.ledger_maxwidth = 80

        vim.g.ledger_default_commodity = "£"
        vim.g.ledger_commodity_before = 1

        -- Use `ga` to align transaction amounts
        vim.keymap.set("x", "ga", function()
            vim.cmd("LedgerAlign")
        end, { buffer = 0 })

        -- Use gs to toggle cleared status
        vim.keymap.set("n", "gs", ":call ledger#transaction_state_toggle(line('.'), ' *!')<CR>")
    end,
}
