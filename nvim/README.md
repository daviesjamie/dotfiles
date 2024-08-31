# Neovim

This is my [Neovim](https://neovim.io/) configuration. Yes, it's using [LazyVim](https://www.lazyvim.org/), don't judge me.

This config essentially uses LazyVim as a proxy to get a well-functioning and externally-managed setup for LSPs ([`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)), code completion ([`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)), code formatting ([`conform.nvim`](https://github.com/stevearc/conform.nvim)) and linting ([`nvim-lint`](https://github.com/mfussenegger/nvim-lint)). Most other aspects of LazyVim are carefully and extensively customised; the default LazyVim options, keys and autocmds are disabled in favour of my own (in [options.lua](.config/nvim/lua/config/options.lua), [keymaps.lua](.config/nvim/lua/config/keymaps.lua) and [autocmds.lua](.config/nvim/lua/config/autocmds.lua)), and the configuration and keybindings for most plugins is overridden in the [plugins/lazyvim](.config/nvim/lua/plugins/lazyvim) directory. I've tried configuring this myself many times, but I'm just not interested in maintaining several hundred lines of lua integration in order to have basic tools like 'go to definition' work as expected.

Some highlights:

- [vim-fugitive](https://github.com/tpope/vim-fugitive), arguably the best vim plugin, for most git operations
  - `<leader>gs` opens an interactive git status window
  - `<leader>gw` opens the current file or visual selection on GitHub/GitLab
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for all the fuzzy finding
  - `<C-p>` searches through all non-git-ignored files
  - `<leader>/` searches for a string in all non-git-ignored files
  - `<leader><space>` resumes the last search after it was closed
- [mini.files](https://github.com/echasnovski/mini.files) for quickly manipulating files
  - `-` opens the file explorer focused on that buffer, but with the path from the working directory visible
  - `_` opens the file explorer centred on the working directory
  - `<leader>/` to open a telescope string search within the currently focussed directory
- a less garish starting screen with [mini.starter](https://github.com/echasnovski/mini.starter)
  - commands and recent files accessible with single-character entry
  - shows a fortune (if you have `fortune` installed)
