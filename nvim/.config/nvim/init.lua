-- Disable LazyVim's default options; I want to specify my own
package.loaded["lazyvim.config.options"] = true

-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
