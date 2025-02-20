return {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = "markdown",
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/notes",
      },
    },
    notes_subdir = "0-inbox",
    daily_notes = {
      folder = "1-journal/daily",
      template = "Daily (Vim).md",
    },
    mappings = {
      ["<leader>nR"] = {
        action = "<cmd>ObsidianRename<cr>",
        opts = { buffer = true, desc = "Rename note" },
      },
      ["<leader>nb"] = {
        action = "<cmd>ObsidianBacklinks<cr>",
        opts = { buffer = true, desc = "List note backlinks" },
      },
      ["<leader>ne"] = {
        action = "<cmd>ObsidianExtractNote<cr>",
        opts = { buffer = true, desc = "Extract to a new note" },
      },
      ["<leader>nl"] = {
        action = "<cmd>ObsidianLinks<cr>",
        opts = { buffer = true, desc = "List note links" },
      },
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    new_notes_location = "notes_subdir",
    note_path_func = function(spec)
      local name = tostring(spec.id)
      if spec.title then
        name = tostring(spec.title)
      end

      local path = spec.dir / name
      return path:with_suffix(".md")
    end,
    disable_frontmatter = true,
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      substitutions = {
        fulldate = function()
          local day = tonumber(os.date("*t").day)
          local ordinal = "th"

          if day then
            local remainder = math.fmod(day, 10)
            if remainder == 1 then
              ordinal = "st"
            elseif remainder == 2 then
              ordinal = "nd"
            elseif remainder == 3 then
              ordinal = "rd"
            end
          end

          return os.date("%A ") .. day .. ordinal .. os.date(" %B")
        end,
        tomorrow = function()
          return os.date("%Y-%m-%d", os.time() + 24 * 60 * 60)
        end,
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 24 * 60 * 60)
        end,
      },
    },
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
    follow_img_func = function(img)
      vim.fn.jobstart({ "qlmanage", "-p", img })
    end,
    open_app_foreground = true,
    attachments = {
      img_folder = "attachments/images",
    },
  },
  keys = {
    { "<leader>n/", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find a note" },
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>nt", "<cmd>ObsidianToday<cr>", desc = "Open today's note" },
  },
}
