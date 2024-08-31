return {
  {
    "echasnovski/mini.files",
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
        go_in = "",
        go_in_plus = "l",
        go_out = "",
        go_out_plus = "h",
      },
    },
    keys = {
      {
        "-",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
          require("mini.files").reveal_cwd()
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "_",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
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

      local go_in_plus = function()
        for _ = 1, vim.v.count1 do
          MiniFiles.go_in({ close_on_file = true })
        end
      end

      local go_in_plus_split = function(direction)
        return function()
          local new_target_window
          local cur_target_window = require("mini.files").get_target_window()
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require("mini.files").set_target_window(new_target_window)
            require("mini.files").go_in({ close_on_file = true })
          end
        end
      end

      local find_files_in_current_dir = function()
        require("mini.files").close()
        LazyVim.pick("files", { root = false, hidden = true, cwd = require("mini.files").get_latest_path() })()
      end

      local grep_in_current_dir = function()
        require("mini.files").close()
        LazyVim.pick("live_grep", { root = false, cwd = require("mini.files").get_latest_path() })()
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set("n", "<CR>", go_in_plus, { buffer = buf_id, desc = "Go in entry plus" })
          vim.keymap.set("n", "<Esc>", MiniFiles.close, { buffer = buf_id, desc = "Close" })

          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })

          vim.keymap.set(
            "n",
            "<C-w>s",
            go_in_plus_split("horizontal"),
            { buffer = buf_id, desc = "Open in horizontal split and close" }
          )
          vim.keymap.set(
            "n",
            "<C-x>",
            go_in_plus_split("horizontal"),
            { buffer = buf_id, desc = "Open in horizontal split and close" }
          )
          vim.keymap.set(
            "n",
            "<C-w>v",
            go_in_plus_split("vertical"),
            { buffer = buf_id, desc = "Open in vertical split and close" }
          )
          vim.keymap.set(
            "n",
            "<C-v>",
            go_in_plus_split("vertical"),
            { buffer = buf_id, desc = "Open in vertical split and close" }
          )

          vim.keymap.set(
            "n",
            "<leader>ff",
            find_files_in_current_dir,
            { buffer = buf_id, desc = "Find files in this directory" }
          )

          vim.keymap.set("n", "<leader>/", grep_in_current_dir, { buffer = buf_id, desc = "Grep in this directory" })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          LazyVim.lsp.on_rename(event.data.from, event.data.to)
        end,
      })
    end,
  },
}
