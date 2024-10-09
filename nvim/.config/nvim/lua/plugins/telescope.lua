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
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      "<C-p>",
      "<leader>,",
      "<leader>/",
      "<leader>:",
      "<leader><space>",
      "<leader>fc",
      "<leader>ff",
      "<leader>fr",
      "<leader>gb",
      "<leader>gc",
      "<leader>gC",
      "<leader>sa",
      "<leader>sc",
      "<leader>sd",
      "<leader>sD",
      "<leader>sh",
      "<leader>sH",
      "<leader>sj",
      "<leader>sk",
      "<leader>sl",
      "<leader>sm",
      "<leader>sM",
      "<leader>so",
      "<leader>sq",
      "<leader>ss",
      "<leader>sS",
      "<leader>sw",
      "<leader>sw",
      '<leader>s"',
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

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

      local map = require("utils").map

      -- stylua: ignore start

      map("n", "<C-p>", find_files_with_scope, "Find files")
      map("n", "<leader>,", function() builtin.buffers({ sort_mru = true, sort_lastused = true }) end, "Switch buffer")
      map("n", "<leader>/", builtin.live_grep, "Grep")
      map("n", "<leader>:", builtin.command_history, "Command history")
      map("n", "<leader><space>", builtin.resume, "Resume")

      -- Find
      map("n", "<leader>fc", function() find_files_with_scope({ cwd = vim.fn.stdpath("config") }) end, "Find config file")
      map("n", "<leader>ff", find_files_with_scope, "Find files")
      map("n", "<leader>fr", builtin.oldfiles, "Recent")

      -- Git
      map("n", "<leader>gb", builtin.git_branches, "Branches")
      map("n", "<leader>gc", builtin.git_bcommits, "Commits (buffer)")
      map("n", "<leader>gC", builtin.git_commits, "Commits (repo)")

      -- Search
      map("n", "<leader>sa", builtin.autocommands, "Auto commands")
      map("n", "<leader>sc", builtin.commands, "Commands")
      map("n", "<leader>sd", function() builtin.diagnostics({ bufnr = 0 }) end, "Diagnostics (buffer)")
      map("n", "<leader>sD", builtin.diagnostics, "Diagnostics (workspace)")
      map("n", "<leader>sh", builtin.help_tags, "Help tags")
      map("n", "<leader>sH", builtin.highlights, "Highlight groups")
      map("n", "<leader>sj", builtin.jumplist, "Jumplist")
      map("n", "<leader>sk", builtin.keymaps, "Keymaps")
      map("n", "<leader>sl", builtin.loclist, "Location list")
      map("n", "<leader>sm", builtin.marks, "Marks")
      map("n", "<leader>sM", builtin.man_pages, "Man pages")
      map("n", "<leader>so", builtin.vim_options, "Options")
      map("n", "<leader>sq", builtin.quickfix, "Quickfix list")
      map("n", "<leader>ss", builtin.lsp_document_symbols, "Symbols (buffer)")
      map("n", "<leader>sS", builtin.lsp_dynamic_workspace_symbols, "Symbols (workspace)")
      map("n", "<leader>sw", function() builtin.grep_string({ word_match = "-w" }) end, "Current word")
      map("v", "<leader>sw", function() builtin.grep_string({ word_match = "-w" }) end, "Selection")
      map("n", '<leader>s"', builtin.registers, "Registers")

      -- stylua: ignore end
    end,
  },
}
