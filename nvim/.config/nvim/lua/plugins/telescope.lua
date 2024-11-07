local find_files_with_scope
find_files_with_scope = function(opts, scope)
  opts = opts or {}

  -- scope is a number between 0-2 (inclusive) controlling
  -- whether hidden/ignored files should be searched
  -- scope defaults to 1 (hidden but not ignored)
  scope = vim.F.if_nil(scope, 1)
  scope = math.min(scope, 2)

  local cycle_scope = function(s)
    return math.fmod(s + 1, 3)
  end

  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<C-\\>", function(prompt_bufnr) -- <C-\> to toggle modes
      local prompt = require("telescope.actions.state").get_current_line()
      require("telescope.actions").close(prompt_bufnr)
      scope = cycle_scope(scope)
      find_files_with_scope({ default_text = prompt }, scope)
    end, { desc = "Toggle hidden/ignored files" })
    return true
  end

  -- | scope | hidden | no_ignore |
  -- |-------|--------|-----------|
  -- | 0     | false  | false     |
  -- | 1     | true   | false     |
  -- | 2     | true   | true      |

  if scope == 0 then
    opts.hidden = false
    opts.no_ignore = false
    opts.prompt_title = "Find Files"
  elseif scope == 1 then
    opts.hidden = true
    opts.no_ignore = false
    opts.prompt_title = "Find Files (inc. hidden)"
  else
    opts.hidden = true
    opts.no_ignore = true
    opts.prompt_title = "Find Files (inc. hidden & ignored)"
  end

  require("telescope.builtin").find_files(opts)
end

local send_selected_or_all_to_qflist = function(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local has_multi_selection = (next(picker:get_multi_selection()) ~= nil)

  if has_multi_selection then
    require("telescope.actions").send_selected_to_qflist(prompt_bufnr)
  else
    require("telescope.actions").send_to_qflist(prompt_bufnr)
  end

  require("telescope.actions").open_qflist(prompt_bufnr)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      { "<C-p>", find_files_with_scope, desc = "Find files" },
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch buffer" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      { "<leader><space>", "<cmd>Telescope resume<cr>", desc = "Resume" },

      -- Find
      {
        "<leader>fc",
        function()
          find_files_with_scope({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find config file",
      },
      { "<leader>ff", find_files_with_scope, desc = "Find files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },

      -- Git
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
      { "<leader>gc", "<cmd>Telescope git_bcommits<cr>", desc = "Commits (buffer)" },
      { "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "Commits (repo)" },

      -- Search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto commands" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Diagnostics (buffer)" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics (workspace)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location list" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man pages" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix list" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symbols (buffer)" },
      { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Symbols (workspace)" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match='-w'<cr>", desc = "Current word" },
      { "<leader>sw", "<cmd>Telescope grep_string word_match='-w'<cr>", mode = "v", desc = "Selection" },
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-e>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-q>"] = send_selected_or_all_to_qflist,
              ["<C-t>"] = require("trouble.sources.telescope").open,
              ["<C-u>"] = false, -- allow <C-u> to clear the line
              ["<C-y>"] = actions.results_scrolling_down,
              ["<C-{>"] = actions.cycle_previewers_prev,
              ["<C-}>"] = actions.cycle_previewers_next,
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
              ["<esc>"] = actions.close,
            },
          },
          pickers = {
            buffers = {
              mappings = {
                i = {
                  ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
                },
              },
            },
            git_branches = {
              mappings = {
                i = {
                  ["<C-d>"] = actions.git_delete_branch + actions.move_to_top,
                },
              },
            },
          },
          prompt_prefix = " ",
          selection_caret = " ",
        },
      })

      telescope.load_extension("fzf")

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Telescope LSP actions",
        callback = function(event)
          local map = require("utils").buffer_map(event.buf)
          local builtin = require("telescope.builtin")

          map("n", "gd", builtin.lsp_definitions, "Goto definition")
          map("n", "gI", builtin.lsp_implementations, "Goto implementation")
          map("n", "gr", builtin.lsp_references, "Find references")
          map("n", "gy", builtin.lsp_type_definitions, "Goto type definition")
        end,
      })
    end,
  },
}
