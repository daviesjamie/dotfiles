if vim.fn.isdirectory(vim.fn.expand("~/src/github.com/monzo")) == 0 then
  return {}
end

-- Treat anything containing these files as a root directory. This
-- prevents us ascending too far toward the root of the repository, which
-- stops us from trying to ingest too much code.
local local_root_dir = function(startpath)
  local root_markers = { "README.md", "main.go", "go.mod", "LICENSE", ".git", "package.json" }
  local matches = vim.fs.find(root_markers, {
    path = startpath,
    upward = true,
    limit = 1,
  })

  -- If there are no matches, fall back to finding the Git ancestor.
  if #matches == 0 then
    return vim.fs.dirname(vim.fs.find(".git", { path = startpath, upward = true })[1])
  end

  local root_dir = vim.fn.fnamemodify(matches[1], ":p:h")
  return root_dir
end

local git_root_dir = function(startpath)
  local paths = vim.fs.find(".git", { path = startpath, upward = true })
  if #paths == 0 then
    return vim.fs.dirname(startpath)
  end
  return vim.fs.dirname(paths[1])
end

return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          analyses = {
            fieldalignment = true,
            nilness = true,
            shadow = true,
            unusedparams = true,
            unusedwrite = true,
          },
          cmd = { "env", "GO111MODULE=off", "gopls", "-remote=auto" },

          flags = {
            -- gopls is a particularly slow language server, especially in wearedev.
            -- Debounce text changes so that we don't send loads of updates.
            debounce_text_changes = 200,
          },

          expandWorkspaceToModule = false,
          ["local"] = "github.com/monzo/wearedev",
          root_dir = local_root_dir,

          init_options = {
            codelenses = {
              generate = true,
              gc_details = true,
              test = true,
              tidy = true,
            },
          },

          directory_filters = {
            "-vendor",
            "-manifests",
          },

          -- Never use wearedev as a root path. It'll grind your machine to a halt.
          ignoredRootPaths = { "$HOME/src/github.com/monzo/wearedev/" },
          -- Collect less information about packages without open files.
          memoryMode = "DegradeClosed",
          staticcheck = true,
        },
        protols = {
          filetypes = { "proto" },
          cmd = {
            "protols",
            "--include-paths="
              .. vim.env.GOPATH
              .. "/src,"
              .. vim.env.GOPATH
              .. "/src/github.com/monzo/wearedev/vendor",
          },
          root_dir = local_root_dir,
        },
        vtsls = {
          root_dir = local_root_dir,
          -- Never use wearedev as a root path. It'll grind your machine to a halt.
          ignoredRootPaths = { "$HOME/src/github.com/monzo/wearedev/" },
        },
        starlark_rust = {
          filetypes = { "star", "bzl", "BUILD.bazel", "starlark" },
          root_dir = local_root_dir,
        },
        yamlls = {
          filetypes = { "yaml", "promql" },
          root_dir = local_root_dir,
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")
      local cwd = vim.fn.getcwd()
      local git_dir = git_root_dir(cwd)
      return {
        debug = true,
        sources = {
          null_ls.builtins.diagnostics.semgrep.with({
            extra_args = {
              "--config=" .. git_dir .. "/static-check-rules",
              "--severity=WARNING",
              "--severity=ERROR",
            },
            timeout = 10000,
            ignore_stderr = true,
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          }),
          null_ls.builtins.diagnostics.buf,
        },
      }
    end,
  },
}
