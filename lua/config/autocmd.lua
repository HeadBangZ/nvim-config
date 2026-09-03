local augroup = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = "Highlight when yanking text",
    group = augroup('highlight-yank'),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp-attach-format"),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client:supports_method("textDocument/formatting", args.buf) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                group = augroup("lsp-format-" .. args.buf),
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end
})

vim.api.nvim_create_autocmd("LspProgress", {
    group = augroup("lsp-progress-echo"),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local val = ev.data.params.value
        if not client or not val then return end

        if val.kind == "end" then
            vim.api.nvim_echo({ { client.name .. " ready", "NotifySuccess" } }, false, {})
            vim.defer_fn(function()
                vim.api.nvim_echo({ { "", "" } }, false, {})
            end, 2000)
        else
            local msg = string.format("%s: %s %s", client.name, val.title or "", val.message or "")
            vim.api.nvim_echo({ { msg, "NotifyText" } }, false, {})
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "nvim-undotree",
    group = augroup("undotree-fix"),
    callback = function()
        vim.api.nvim_win_set_width(0, 40)
        vim.opt_local.winfixwidth = true
    end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    desc = "Sort quickfix list by line number",
    group = augroup("quickfix-sort"),
    callback = function()
        local q = vim.fn.getqflist()
        table.sort(q, function(a, b)
            return a.bufnr == b.bufnr and a.lnum < b.lnum or a.bufnr < b.bufnr
        end)
        vim.fn.setqflist(q, "r")
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup("notify-buf-write"),
    callback = function(args)
        local fname = vim.fn.fnamemodify(args.file, ":t")
        vim.notify("Saved " .. fname, vim.log.levels.INFO)
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "GitSignsUpdate",
    group = augroup("gitsigns-notify"),
    callback = function()
        local branch = vim.b.gitsigns_head
        if branch then
            vim.api.nvim_echo({ { "Git Branch: " .. branch, "NotifyInfo" } }, false, {})
        end
    end,
})

vim.api.nvim_create_user_command("ReloadConfig", function()
    for name, _ in pairs(package.loaded) do
        if name:match("^config") or name:match("^core") or name:match("^plugins") or name:match("^custom") then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)

    vim.cmd("bufdo e")

    vim.notify("Neovim configuration reloaded successfully!", vim.log.levels.INFO)
end, {})
