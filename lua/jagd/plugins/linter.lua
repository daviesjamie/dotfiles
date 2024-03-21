local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        local eslint_fts = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        }

        for _, ft in ipairs(eslint_fts) do
            lint.linters_by_ft[ft] = { "eslint_d" }
        end

        local linter_group = augroup("linter", { clear = true })
        autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = linter_group,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>ll", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
