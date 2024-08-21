return {
  { "tpope/vim-sleuth" },
  { "tpope/vim-surround" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>ge", false },
    },
  },
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
      { "<leader><space>", false },
      { "<leader>gs", false },

      { "<C-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>gC", "<cmd>Telescope git_bcommits<CR>", desc = "Commits (buffer)" },
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
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/notes",
        },
      },
      notes_subdir = "0-inbox",
      daily_notes = {
        folder = "1-journal",
        template = "Daily.md",
      },
      templates = {
        folder = "templates",
      },
    },
  },
}
