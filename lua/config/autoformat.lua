local fmt_group = vim.api.nvim_create_augroup('autoformat_cmds', { clear = true })

local function setup_autoformat(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then
        return
    end

    if client:supports_method("textDocument/completion") then
        vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = event.buf })

        local buf_format = function(e)
            vim.lsp.buf.format({
                bufnr = e.buf,
                async = false,
                timeout_ms = 10000,
            })
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = event.buf,
            group = fmt_group,
            desc = 'Format current buffer',
            callback = buf_format,
        })
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Setup format on save',
    callback = setup_autoformat,
})
