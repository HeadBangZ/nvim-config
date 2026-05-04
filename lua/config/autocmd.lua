---@diagnostic disable-next-line: missing-parameter
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        ---@diagnostic disable-next-line: missing-parameter
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end
})

vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local val = ev.data.params.value
        if not client or not val then return end

        local msg = string.format("%s: %s %s",
            client.name,
            val.message or "",
            val.title or ""
        )

        if val.kind == "end" then
            vim.api.nvim_echo({ { client.name .. " loaded", "Comment" } }, false, {})
            vim.defer_fn(function() vim.api.nvim_echo({ { "", "" } }, false, {}) end, 2000)
        else
            vim.api.nvim_echo({ { msg, "Comment" } }, false, {})
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "nvim-undotree",
    callback = function()
        vim.api.nvim_win_set_width(0, 55)
        vim.opt_local.winfixwidth = true
    end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    desc = "Sort quickfix list by line number",
    group = vim.api.nvim_create_augroup("quickfix-sort", { clear = true }),
    callback = function()
        local q = vim.fn.getqflist()
        table.sort(q, function(a, b)
            return a.bufnr == b.bufnr and a.lnum < b.lnum or a.bufnr < b.bufnr
        end)
        vim.fn.setqflist(q, "r")
    end,
})

vim.api.nvim_create_autocmd({ "LspProgress", "ModeChanged", "BufWinEnter", "CursorHold", "CursorHoldI", "FocusGained" },
    {
        callback = function()
            vim.cmd("redrawstatus")
        end,
    })
