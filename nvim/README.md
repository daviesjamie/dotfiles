# Neovim

This is my [Neovim](https://neovim.io/) configuration.

Some highlights:

- [vim-fugitive](https://github.com/tpope/vim-fugitive), arguably the best vim plugin, for most git operations
  - `<leader>gs` opens an interactive git status window
  - `<leader>gw` opens the current file or visual selection on GitHub/GitLab
- [mini.files](https://github.com/echasnovski/mini.files) for quickly manipulating files
  - `-` opens the file explorer focused on that buffer, but with the path from the working directory visible
  - `_` opens the file explorer centred on the working directory
  - `<leader>/` to open a telescope string search within the currently focused directory
  - `<C-x>` and `<C-v>` opens the selected file in a horizontal/vertical split
  - `<C-\>` can be used to toggle hidden files
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for all the fuzzy finding
  - `<C-p>` searches through all files, and `<C-\>` can be used in this finder to toggle hidden files
  - `<leader>/` searches for a string in all non-git-ignored files
  - `<leader><space>` resumes the last search after it was closed
  - `<C-q>` sends selected items to quickfix list, or all items if none are selected
- [conform.nvim](https://github.com/stevearc/conform.nvim) for formatting code
  - Format code with `<leader>cf`
  - Formats on save, which can be switched on/off with `:FormatEnable` and `:FormatDisable`
- [blink.cmp](https://github.com/Saghen/blink.cmp) for autocompletion
- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) for project-wide find-and-replace
- [mason.nvim](https://github.com/williamboman/mason.nvim) for binary/tool installation
