local M = {}

M.on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- LSP Search / Navigation (Fzf-lua)
    vim.keymap.set("n", "gd", function() require('fzf-lua').lsp_definitions() end, opts)
    vim.keymap.set("n", "gD", function() require('fzf-lua').lsp_declarations() end, opts)
    vim.keymap.set("n", "grr", function() require('fzf-lua').lsp_references() end, opts)
    vim.keymap.set("n", "gic", function() require('fzf-lua').lsp_incoming_calls() end, opts)
    vim.keymap.set("n", "gri", function() require('fzf-lua').lsp_implementations() end, opts)
    vim.keymap.set("n", "grt", function() require('fzf-lua').lsp_typedefs() end, opts)
    vim.keymap.set("n", "gs", function() require('fzf-lua').lsp_document_symbols() end, opts)
    vim.keymap.set("n", "gS", function() require('fzf-lua').lsp_workspace_symbols() end, opts)
    vim.keymap.set("n", "<leader>lD", function() require('fzf-lua').diagnostics_workspace() end, opts)
    vim.keymap.set("n", "<leader>ld", function() require('fzf-lua').diagnostics_document() end, opts)

    -- LSP Actions
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-a>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Diagnostics
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
end

return M
