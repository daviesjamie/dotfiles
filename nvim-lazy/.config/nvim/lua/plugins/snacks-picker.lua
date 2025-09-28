local pick_directory = function()
  local find_command = {
    "fd",
    -- Only show directories
    "--type",
    "dir",
    -- We don't need any colours
    "--color",
    "never",
    -- Only find top-level directories
    "--max-depth",
    "1",
    -- Always get directories from 'root' cwd
    "--full-path",
    vim.fn.getcwd(-1, -1),
  }

  vim.fn.jobstart(find_command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        local filtered = vim.tbl_filter(function(el)
          return el ~= ""
        end, data)

        local items = {}
        for _, v in ipairs(filtered) do
          table.insert(items, { text = v })
        end

        --@module 'snacks'
        Snacks.picker.pick({
          source = "directories",
          items = items,
          layout = { preset = "select" },
          format = "text",
          confirm = function(picker, item)
            picker:close()
            vim.cmd("tabnew")
            vim.cmd("tcd " .. item.text)

            if vim.fn.exists(":Tabby") then
              local tabname = item.text:gsub("%bservice%.", "s.")
              vim.cmd("Tabby rename_tab " .. tabname)
            end

            -- Workaround: opening a new tab from the dashboard doesn't make tabline show
            -- when showtabline=1 (the default)
            vim.o.showtabline = 2
          end,
        })
      end
    end,
  })
end

return {
  "snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["<C-x>"] = { "edit_split", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<C-x>"] = { "edit_split", mode = { "i", "n" } },
          },
        },
      },
    },
  },
  keys = {
    -- Custom directory tab picker
    { "<C-t>", pick_directory, desc = "Open directory in new tab" },

    -- Add extra keybindings for file picker
    { "<C-p>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },

    -- Disable git picker keybindings
    { "<leader>gd", false },
    { "<leader>gs", false },
    { "<leader>gS", false },
  },
}
