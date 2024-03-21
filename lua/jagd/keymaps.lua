vim.g.mapleader = " "

local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

M.core = function()
    vim.keymap.set(
        "n",
        "<leader>pv",
        vim.cmd.Ex,
        { desc = "Project View: Open Netrw" }
    )

    -- Make jumping with Ctrl D/U stay centered in screen
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")

    -- Open folds when jumping between seach results
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")

    -- Make yanking/pasting to/from system clipboard a bit easier
    vim.keymap.set(
        { "n", "v" },
        "<leader>y",
        [["+y]],
        { desc = "Copy to system clipboard" }
    )

    vim.keymap.set(
        "n",
        "<leader>Y",
        [["+Y]],
        { desc = "Copy rest of line to system clipboard" }
    )

    vim.keymap.set("x", "<leader>p", [["_dP]], {
        desc = "Paste over visual selection without losing register contents",
    })

    -- Stop accidentally pressing Q
    vim.keymap.set("n", "Q", "<nop>")

    -- Quickly move visual selection up/down
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    -- Re-select selection after indenting in visual mode
    vim.keymap.set("v", ">", ">gv")
    vim.keymap.set("v", "<", "<gv")

    -- vim-unimparied: arglist
    vim.keymap.set("n", "[a", function()
        vim.cmd("silent! " .. vim.v.count1 .. "previous")
    end, { desc = "Jump to [count] previous file in arglist" })
    vim.keymap.set("n", "]a", function()
        vim.cmd("silent! " .. vim.v.count1 .. "next")
    end, { desc = "Jump to [count] next file in arglist" })
    vim.keymap.set("n", "[A", function()
        vim.cmd("first")
    end, { desc = "Jump to first file in arglist" })
    vim.keymap.set("n", "]A", function()
        vim.cmd("last")
    end, { desc = "Jump to last file in arglist" })

    -- vim-unimpaired: buffers
    vim.keymap.set("n", "[b", function()
        vim.cmd(vim.v.count1 .. "bprevious")
    end, { desc = "Jump to [count] previous buffer" })
    vim.keymap.set("n", "]b", function()
        vim.cmd(vim.v.count1 .. "bnext")
    end, { desc = "Jump to [count] next buffer" })
    vim.keymap.set("n", "[B", function()
        vim.cmd("bfirst")
    end, { desc = "Jump to first buffer" })
    vim.keymap.set("n", "]B", function()
        vim.cmd("blast")
    end, { desc = "Jump to last buffer" })

    -- vim-unimpaired: loclist
    vim.keymap.set("n", "[l", function()
        vim.cmd("silent! " .. vim.v.count1 .. "lprevious")
    end, { desc = "Jump to [count] previous entry in loclist" })
    vim.keymap.set("n", "]l", function()
        vim.cmd("silent! " .. vim.v.count1 .. "lnext")
    end, { desc = "Jump to [count] next entry in loclist" })
    vim.keymap.set("n", "[L", function()
        vim.cmd("lfirst")
    end, { desc = "Jump to first entry in loclist" })
    vim.keymap.set("n", "]L", function()
        vim.cmd("llast")
    end, { desc = "Jump to last entry in loclist" })

    -- vim-unimpaired: quickfix
    vim.keymap.set("n", "[q", function()
        vim.cmd("silent! " .. vim.v.count1 .. "cprevious")
    end, { desc = "Jump to [count] previous entry in quickfix list" })
    vim.keymap.set("n", "]q", function()
        vim.cmd("silent! " .. vim.v.count1 .. "cnext")
    end, { desc = "Jump to [count] next entry in quickfix list" })
    vim.keymap.set("n", "[Q", function()
        vim.cmd("cfirst")
    end, { desc = "Jump to first entry in quickfix list" })
    vim.keymap.set("n", "]Q", function()
        vim.cmd("clast")
    end, { desc = "Jump to last entry in quickfix list" })
end

M.lsp = function(buffer)
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, {
        buffer = buffer,
        desc = "Go to Definition",
    })

    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, { buffer = buffer })

    vim.keymap.set("n", "<leader>ls", function()
        vim.lsp.buf.workspace_symbol()
    end, {
        buffer = buffer,
        desc = "LSP: Search workspace for Symbol",
    })

    vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.open_float()
    end, {
        buffer = buffer,
        desc = "LSP: view Diagnostic float",
    })

    vim.keymap.set("n", "<leader>lca", function()
        vim.lsp.buf.code_action()
    end, {
        buffer = buffer,
        desc = "LSP: select a Code Action",
    })

    vim.keymap.set("n", "<leader>.", function()
        vim.lsp.buf.code_action()
    end, {
        buffer = buffer,
        desc = "LSP: select a code action",
    })

    vim.keymap.set("n", "<leader>lr", function()
        vim.lsp.buf.references()
    end, {
        buffer = buffer,
        desc = "LSP: find symbol References",
    })

    vim.keymap.set("n", "<leader>lR", function()
        vim.lsp.buf.rename()
    end, {
        buffer = buffer,
        desc = "LSP: Rename symbol",
    })

    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, { buffer = buffer })

    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev()
    end, {
        buffer = buffer,
        desc = "Jump to previous diagnostic",
    })

    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next()
    end, {
        buffer = buffer,
        desc = "Jump to next diagnostic",
    })
end

M.fugitive = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

    local jagd_fugitive_group = augroup("jagd_fugitive", { clear = true })
    autocmd("BufWinEnter", {
        group = jagd_fugitive_group,
        pattern = "*",
        callback = function()
            if vim.bo.ft ~= "fugitive" then
                return
            end

            local bufnr = vim.api.nvim_get_current_buf()

            vim.keymap.set("n", "<leader>gp", function()
                vim.cmd.Git("push")
            end, {
                buffer = bufnr,
                remap = false,
                desc = "Git Push",
            })

            vim.keymap.set("n", "<leader>gP", function()
                vim.cmd.Git("push --force-with-lease")
            end, {
                buffer = bufnr,
                remap = false,
                desc = "Git Push --Force-with-lease",
            })

            vim.keymap.set("n", "<leader>gu", function()
                vim.cmd.Git({ "pull", "--rebase" })
            end, {
                buffer = bufnr,
                remap = false,
                desc = "Git Pull --rebase",
            })
        end,
    })
end

M.telescope = function(telescope_builtin)
    vim.keymap.set(
        "n",
        "<C-p>",
        telescope_builtin.find_files,
        { desc = "Fuzzy find files" }
    )

    vim.keymap.set(
        "n",
        "<leader>pf",
        telescope_builtin.find_files,
        { desc = "Project Find: fuzzy find files" }
    )

    vim.keymap.set(
        "n",
        "<leader>ps",
        telescope_builtin.live_grep,
        { desc = "Project Search: search project for string" }
    )

    vim.keymap.set(
        "n",
        "<leader>p/",
        telescope_builtin.live_grep,
        { desc = "Project Search: search project for string" }
    )

    vim.keymap.set("n", "<leader>pw", function()
        local word = vim.fn.expand("<cword>")
        telescope_builtin.grep_string({ search = word })
    end, { desc = "Project Word: search project for word" })

    vim.keymap.set("n", "<leader>pW", function()
        local word = vim.fn.expand("<cWORD>")
        telescope_builtin.grep_string({ search = word })
    end, { desc = "Project WORD: search project for WORD" })
end

return M
