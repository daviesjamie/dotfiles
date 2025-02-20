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

    -- Remap `<leader>f` bindings to use vim-ledger's formatting
    vim.keymap.set("n", "<leader>f", ":LedgerAlignBuffer<CR>", { desc = "Format buffer" })
    vim.keymap.set("v", "<leader>f", ":LedgerAlign<CR>", { desc = "Format selection" })

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("jagd_ledger_format", { clear = true }),
      pattern = "*",
      command = "LedgerAlignBuffer",
    })

    -- Use `gs` to toggle cleared status
    vim.keymap.set(
      "n",
      "gs",
      ":call ledger#transaction_state_toggle(line('.'), ' *!')<CR>",
      { desc = "Toggle transaction status" }
    )
  end,
}
