return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },

    -- Override next/prev buffer keymaps from basic config to allow
    -- navigating buffer tabs in order
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  opts = {
    options = {
      always_show_bufferline = false,
      close_command = function(n)
        require("jagd.utils").buffer_delete(n)
      end,
    },
  },
}
