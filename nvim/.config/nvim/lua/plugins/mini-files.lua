return {
  "echasnovski/mini.files",
  lazy = false, -- Required to get `use_as_default_explorer` to work with arglist
  keys = {
    {
      "-",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        require("mini.files").reveal_cwd()
      end,
      desc = "Open mini.files (dir of current file)",
    },
    {
      "_",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    options = {
      use_as_default_explorer = true,
    },
    mappings = {
      close = "<Esc>",
      go_in = "L",
      go_in_plus = "l",
      go_out = "H",
      go_out_plus = "h",
    },
  },
  config = function(_, opts)
    require("mini.files").setup(opts)

    local show_dotfiles = true
    local filter_show = function(_)
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require("mini.files").refresh({ content = { filter = new_filter } })
    end

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. " split")
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)
        MiniFiles.go_in({ close_on_file = true })
      end

      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
    end

    local find_files_in_current_dir = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then
        return vim.notify("Cursor is not on a valid entry")
      end

      local dir = vim.fn.isdirectory(path) ~= 0 and path or vim.fs.dirname(path)

      MiniFiles.close()
      require("telescope.builtin").find_files({ cwd = dir })
    end

    local grep_in_current_dir = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then
        return vim.notify("Cursor is not on a valid entry")
      end

      local dir = vim.fn.isdirectory(path) ~= 0 and path or vim.fs.dirname(path)

      MiniFiles.close()
      require("telescope.builtin").find_files({ cwd = dir })
    end

    -- Add mappings
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set("n", "<C-\\>", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })

        map_split(buf_id, "<C-x>", "horizontal")
        map_split(buf_id, "<C-v>", "vertical")

        vim.keymap.set("n", "<leader>/", grep_in_current_dir, { buffer = buf_id, desc = "Grep in current dir" })

        vim.keymap.set("n", "<C-p>", find_files_in_current_dir, { buffer = buf_id, desc = "Find files in current dir" })
        vim.keymap.set(
          "n",
          "<leader>ff",
          find_files_in_current_dir,
          { buffer = buf_id, desc = "Find files in current dir" }
        )
      end,
    })
  end,
}
