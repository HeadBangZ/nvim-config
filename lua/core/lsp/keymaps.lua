local M = {}

M.on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", "<Cmd>FzfLua lsp_definitions()<CR>", opts)
    vim.keymap.set("n", "gD", "<Cmd>FzfLua lsp_declarations()<CR>", opts)
    vim.keymap.set("n", "grr", "<Cmd>FzfLua lsp_references()<CR>", opts)
    vim.keymap.set("n", "gri", "<Cmd>FzfLua lsp_implementations()<CR>", opts)
    vim.keymap.set("n", "grt", "<Cmd>FzfLua lsp_typedefs()<CR>", opts)
    vim.keymap.set("n", "gs", "<Cmd>FzfLua lsp_document_symbols()<CR>", opts)
    vim.keymap.set("n", "gS", "<Cmd>FzfLua lsp_workspace_symbols()<CR>", opts)
    vim.keymap.set("n", "<leader>fd", "<Cmd>FzfLua diagnostics_workspace()<CR>", opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-a>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Diagnostics (The modern, non-deprecated way)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
end

return M
