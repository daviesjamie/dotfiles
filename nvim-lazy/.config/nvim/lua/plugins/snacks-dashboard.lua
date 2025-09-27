local hl_filepath = function(filepath)
  local dir, file = filepath:match("^(.*)/(.+)$")
  if dir then
    return { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
  end
  return { { filepath, hl = "file" } }
end

local shorten_filepath = function(item, ctx)
  local fname = vim.fn.fnamemodify(item.file, ":~")
  local cwd = vim.fn.fnamemodify(".", ":~")

  fname = fname:gsub(cwd .. "/", "")
  fname = fname:gsub("%bservice%.", "s.")

  if #fname <= ctx.width then
    return fname
  end

  local dir = vim.fn.fnamemodify(fname, ":h")
  local file = vim.fn.fnamemodify(fname, ":t")
  if dir and file then
    file = file:sub(-(ctx.width - #dir - 2))
    fname = dir .. "/…" .. file
    return fname
  end

  return vim.fn.pathshorten(fname)
end

return {
  "snacks.nvim",
  opts = {
    dashboard = {
      width = 80,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "files", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "s", desc = "search", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "g", desc = "git", action = ":Git | :only" },
          { icon = " ", key = "p", desc = "pr", action = ":Octo pr list" },
          {
            icon = "󰖟 ",
            key = "r",
            desc = "repo",
            action = function()
              Snacks.gitbrowse()
            end,
          },
          { icon = "󰒲 ", key = "l", desc = "lazy", action = ":Lazy" },
        },
      },
      formats = {
        file = function(item, ctx)
          return hl_filepath(shorten_filepath(item, ctx))
        end,
      },
      sections = {
        { title = vim.fn.fnamemodify(".", ":~"), padding = 1 },
        { section = "keys", padding = 1 },
        {
          section = "recent_files",
          padding = 3,
          limit = 5,
          cwd = true,
          filter = function(file)
            if file:match("/.git/") then
              return false
            end
            return true
          end,
        },
        { section = "startup" },
      },
    },
  },
}
