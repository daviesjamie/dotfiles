local autocmd = vim.api.nvim_create_autocmd
local augroup = require("utils").augroup

return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    dependencies = {
      "tpope/vim-rhubarb",
      "shumphrey/fugitive-gitlab.vim",
    },
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Git status" },
      { "<leader>gS", "<cmd>Git<cr>", desc = "Git status (vertical)" },
      { "<leader>gw", "<cmd>GBrowse<cr>", desc = "Open line in git web UI" },
      { "<leader>gW", "<cmd>GBrowse!<cr>", desc = "Copy URL to line in git web UI" },
      { "<leader>gw", "<cmd>GBrowse<cr>", mode = "v", desc = "Open selection in git web UI" },
      { "<leader>gW", "<cmd>GBrowse!<cr>", mode = "v", desc = "Copy URL to selection in git web UI" },
    },
    config = function()
      autocmd("BufWinEnter", {
        group = augroup("fugitive"),
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()

          vim.keymap.set("n", "<leader>gp", function()
            vim.cmd.Git("push")
          end, {
            buffer = bufnr,
            remap = false,
            desc = "[G]it [P]ush",
          })

          vim.keymap.set("n", "<leader>gP", function()
            vim.cmd.Git("push --force-with-lease")
          end, {
            buffer = bufnr,
            remap = false,
            desc = "[G]it [P]ush --force",
          })

          vim.keymap.set("n", "<leader>gu", function()
            vim.cmd.Git("pull --rebase")
          end, { buffer = bufnr, remap = false, desc = "Git P[u]ll --rebase" })
        end,
      })
    end,
  },
}
