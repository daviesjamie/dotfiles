return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb",
    "shumphrey/fugitive-gitlab.vim",
  },
  cmd = { "Git", "GBrowse", "Gclog", "Gdiffsplit", "Gedit", "Ggrep", "Gread", "Gsplit", "Gvsplit", "Gwrite" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>gS", "<cmd>vertical Git<cr>", desc = "Git status (vertical)" },
    { "<leader>gw", "<cmd>GBrowse<cr>", desc = "Open line in git web UI" },
    { "<leader>gW", "<cmd>GBrowse!<cr>", desc = "Copy URL to line in git web UI" },
    { "<leader>gw", "<cmd>GBrowse<cr>", mode = "v", desc = "Open selection in git web UI" },
    { "<leader>gW", "<cmd>GBrowse!<cr>", mode = "v", desc = "Copy URL to selection in git web UI" },
  },
  config = function()
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("jagd_fugitive_index_keymaps", { clear = true }),
      pattern = "FugitiveIndex",
      callback = function(event)
        vim.keymap.set("n", "<leader>gp", function()
          vim.cmd.Git("push")
        end, {
          buffer = true,
          remap = false,
          desc = "git push",
        })

        vim.keymap.set("n", "<leader>gP", function()
          vim.cmd.Git("push --force-with-lease")
        end, {
          buffer = true,
          remap = false,
          desc = "git push --force-with-lease",
        })

        vim.keymap.set("n", "<leader>gu", function()
          vim.cmd.Git("pull --rebase")
        end, {
          buffer = true,
          remap = false,
          desc = "git pull --rebase",
        })
      end,
    })
  end,
}
