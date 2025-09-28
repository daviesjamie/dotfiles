return {
  "lewis6991/gitsigns.nvim",
  opts = function(_, opts)
    local prev_on_attach = opts.on_attach
    opts.on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      prev_on_attach(buffer)

      vim.keymap.del("n", "<leader>ghb", { buffer = buffer })
      vim.keymap.del("n", "<leader>ghB", { buffer = buffer })
      vim.keymap.set("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, { buffer = buffer, desc = "Blame Line", silent = true })
      vim.keymap.set("n", "<leader>gB", function()
        gs.blame()
      end, { buffer = buffer, desc = "Blame Buffer", silent = true })
    end
    return opts
  end,
}
