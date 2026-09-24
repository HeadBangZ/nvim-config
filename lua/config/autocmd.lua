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

vim.api.nvim_create_autocmd("FileType", {
    desc = "Hide colorcolumn in markdown",
    group = augroup("markdown-colorcolumn"),
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.colorcolumn = ""
    end,
})

local format_group = augroup("lsp-format-on-save")

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp-attach-format"),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        if not client:supports_method("textDocument/formatting", args.buf) then return end

        vim.api.nvim_clear_autocmds({ group = format_group, buffer = args.buf })
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            group = format_group,
            callback = function()
                if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
                    return
                end
                vim.lsp.buf.format({ bufnr = args.buf })
            end,
        })
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Don't continue comments on new lines",
    group = augroup("no-auto-comment"),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_user_command("FormatOnSave", function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    vim.notify(
        "Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"),
        vim.log.levels.INFO
    )
end, { desc = "Toggle format on save" })

vim.api.nvim_create_autocmd("LspProgress", {
    group = augroup("lsp-progress-echo"),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local val = ev.data.params.value
        if not client or not val then return end

        if val.kind == "end" then
            vim.notify(client.name .. " ready", vim.log.levels.INFO)
        elseif val.kind == "begin" then
            local msg = string.format("%s: %s", client.name, val.title or "")
            vim.notify(msg, vim.log.levels.INFO)
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

    vim.cmd("bufdo e!")

    vim.notify("Neovim configuration reloaded successfully!", vim.log.levels.INFO)
end, {})

local jupytext_group = augroup("jupytext")

vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
    group = jupytext_group,
    pattern = "*.ipynb",
    callback = function(args)
        local buf = args.buf
        local file = args.file

        local cmd = string.format("jupytext --to md --output - %s", vim.fn.shellescape(file))
        local output = vim.fn.systemlist(cmd)

        if vim.v.shell_error ~= 0 then
            vim.notify("Jupytext failed to convert notebook", vim.log.levels.ERROR)
            return
        end

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
        vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })
        vim.api.nvim_set_option_value("modified", false, { buf = buf })

        vim.api.nvim_create_autocmd("BufWriteCmd", {
            buffer = buf,
            group = jupytext_group,
            callback = function()
                local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                local tmp_md = vim.fn.tempname() .. ".md"
                vim.fn.writefile(content, tmp_md)

                local update_cmd = string.format("jupytext --to ipynb --output %s %s", vim.fn.shellescape(file),
                    vim.fn.shellescape(tmp_md))
                vim.fn.system(update_cmd)
                vim.fn.delete(tmp_md)

                vim.api.nvim_set_option_value("modified", false, { buf = buf })
            end,
        })
    end,
})
