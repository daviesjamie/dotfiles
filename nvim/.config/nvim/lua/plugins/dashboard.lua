return {
  {
    "echasnovski/mini.starter",
    opts = function()
      local starter = require("mini.starter")

      local greeting = function()
        local name = os.getenv("USER")
        local hour = tonumber(vim.fn.strftime("%H"))
        local period = ""
        local icon = ""

        if hour < 5 or hour > 21 then
          period = "night"
          icon = "󰖔"
        elseif hour < 12 then
          period = "morning"
          icon = ""
        elseif hour < 17 then
          period = "afternoon"
          icon = ""
        else
          period = "evening"
          icon = ""
        end

        return ("%s  Good %s, %s."):format(icon, period, name)
      end

      local telescope_actions = {
        { name = "Find file", action = LazyVim.pick("files", { root = false, hidden = true }), section = "Telescope" },
        { name = "Recent files", action = LazyVim.pick("oldfiles", { root = false }), section = "Telescope" },
        { name = "Search", action = LazyVim.pick("live_grep", { root = false }), section = "Telescope" },
        { name = "Git commits", action = LazyVim.pick("git_commits", { root = false }), section = "Telescope" },
        { name = "Help", action = LazyVim.pick("help_tags"), section = "Telescope" },
      }

      return {
        evaluate_single = true,
        header = greeting(),
        items = {
          starter.sections.recent_files(5, true),
          telescope_actions,
          starter.sections.builtin_actions(),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("all", { "Builtin actions", "Telescope" }),
          starter.gen_hook.aligning("center", "center"),
        },
      }
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function(ev)
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          starter.config.footer = ("⚡ Neovim loaded %d / %d plugins in %d ms"):format(stats.loaded, stats.count, ms)
          -- INFO: based on @echasnovski's recommendation (thanks a lot!!!)
          if vim.bo[ev.buf].filetype == "ministarter" then
            pcall(starter.refresh)
          end
        end,
      })
    end,
  },
}
