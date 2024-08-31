return {
  { "folke/flash.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/which-key.nvim",
    opts = {
      icons = {
        mappings = false,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Find
      { "<C-p>", LazyVim.pick("files", { root = false, hidden = true }), desc = "Find Files (cwd)" },
      { "<leader>ff", LazyVim.pick("files", { root = false, hidden = true }), desc = "Find Files (cwd)" },
      { "<leader>fF", false },
      { "<leader>fR", false },

      -- Git
      { "<leader>gC", "<cmd>Telescope git_bcommits<CR>", desc = "Commits (buffer)" },
      { "<leader>gs", false },

      -- Search
      { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sC", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader><space>", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sR", false },
      { "<leader>sw", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sW", false },
      { "<leader>sw", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>sW", false, mode = "v" },
    },
    opts = function()
      local actions = require("telescope.actions")

      local send_selected_or_all_to_qflist = function(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local has_multi_selection = (next(picker:get_multi_selection()) ~= nil)

        if has_multi_selection then
          actions.send_selected_to_qflist(prompt_bufnr)
        else
          actions.send_to_qflist(prompt_bufnr)
        end

        actions.open_qflist(prompt_bufnr)
      end

      return {
        defaults = {
          file_ignore_patterns = { "^.git/" },
          mappings = {
            i = {
              ["<M-t>"] = false,
              ["<M-i>"] = false,
              ["<M-h>"] = false,
              ["<M-f>"] = false,
              ["<M-k>"] = false,
              ["<M-q>"] = false,
              ["<C-Down>"] = false,
              ["<C-Up>"] = false,
              ["<C-b>"] = false,

              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-f>"] = actions.preview_scrolling_left,
              ["<C-k>"] = actions.preview_scrolling_right,

              ["<C-q>"] = send_selected_or_all_to_qflist,
            },
            n = {
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-f>"] = actions.preview_scrolling_left,
              ["<C-k>"] = actions.preview_scrolling_right,

              ["<C-q>"] = send_selected_or_all_to_qflist,
            },
          },
        },
      }
    end,
  },
}
