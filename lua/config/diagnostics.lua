local signs = {
    Error = "󰅚 ",
    Warn  = " ",
    Hint  = "󰋼 ",
    Info  = "󰝶 ",
}

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN]  = signs.Warn,
            [vim.diagnostic.severity.HINT]  = signs.Hint,
            [vim.diagnostic.severity.INFO]  = signs.Info,
        }
    },
    virtual_lines = { current_line = true },
    virtual_text = false,
    update_in_insert = false,
    severity_sort = true
})
