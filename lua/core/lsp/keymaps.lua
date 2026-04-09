-- lua/core/lsp/keymaps.lua
local M = {}

M.on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Use the correct Lua call syntax
    vim.keymap.set("n", "gd", "<Cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts)
    vim.keymap.set("n", "gD", "<Cmd>lua require('fzf-lua').lsp_declarations()<CR>", opts)
    vim.keymap.set("n", "grr", "<Cmd>lua require('fzf-lua').lsp_references()<CR>", opts)
    vim.keymap.set("n", "gri", "<Cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
    vim.keymap.set("n", "grt", "<Cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
    vim.keymap.set("n", "gs", "<Cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", opts)
    vim.keymap.set("n", "gS", "<Cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>", opts)
    vim.keymap.set("n", "<leader>fd", "<Cmd>lua require('fzf-lua').diagnostics_workspace()<CR>", opts)

    -- Native LSP functions
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-a>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Diagnostics
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
end

return M
