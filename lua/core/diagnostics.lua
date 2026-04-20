local signs = {
    Error = "󰅚 ",
    Warn  = " ",
    Hint  = "󰋼 ",
    Info  = "󰝶 ",
}

for type, icon in ipairs(signs) do
    local name = "DiagnosticSign" .. type
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN]  = signs.Warn,
            [vim.diagnostic.severity.HINT]  = signs.Hint,
            [vim.diagnostic.severity.INFO]  = signs.Info,
        }
    },
    update_in_insert = false,
    severity_sort = true
})
