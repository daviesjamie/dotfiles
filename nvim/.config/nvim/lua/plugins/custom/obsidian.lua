return {
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
