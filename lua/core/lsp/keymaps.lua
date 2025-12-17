local M = {}
M.on_attach = function(client, bufnr)
    local function map_buf_key(mode, lhs, rhs, opts)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    local opts = { noremap = true, silent = true }

    map_buf_key('n', 'gd', '<Cmd>lua require("fzf-lua").lsp_definitions()<CR>', opts)
    map_buf_key('n', 'gD', '<Cmd>lua require("fzf-lua").lsp_declarations()<CR>', opts)
    map_buf_key('n', 'grr', '<Cmd>lua require("fzf-lua").lsp_references()<CR>', opts)
    map_buf_key('n', 'gri', '<Cmd>lua require("fzf-lua").lsp_implementations()<CR>', opts)
    map_buf_key('n', 'grt', '<Cmd>lua require("fzf-lua").lsp_typedefs()<CR>', opts)
    map_buf_key('n', 'gs', '<Cmd>lua require("fzf-lua").lsp_document_symbols()<CR>', opts)
    map_buf_key('n', 'gS', '<Cmd>lua require("fzf-lua").lsp_workspace_symbols()<CR>', opts)
    map_buf_key('n', '<leader>d', '<Cmd>lua require("fzf-lua").diagnostics_workspace()<CR>', opts)

    map_buf_key('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map_buf_key('n', '<C-a>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map_buf_key('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    map_buf_key('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    map_buf_key("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    map_buf_key("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

return M
