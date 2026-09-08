local M = {}

M.on_attach = function(_, bufnr)
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end

    local function fzf_cmd(cmd_name)
        return function()
            require("fzf-lua")[cmd_name]()
        end
    end

    -- LSP Navigation (Lazy fzf-lua)
    map("n", "gd", fzf_cmd("lsp_definitions"), "LSP: [G]oto [D]efinition")
    map("n", "gD", fzf_cmd("lsp_declarations"), "LSP: [G]oto [D]eclaration")
    map("n", "grr", fzf_cmd("lsp_references"), "LSP: [G]oto [R]eferences")
    map("n", "gic", fzf_cmd("lsp_incoming_calls"), "LSP: [G]oto [I]ncoming [C]alls")
    map("n", "gri", fzf_cmd("lsp_implementations"), "LSP: [G]oto [I]mplementation")
    map("n", "grt", fzf_cmd("lsp_typedefs"), "LSP: [G]oto [T]ype Definition")
    map("n", "gs", fzf_cmd("lsp_document_symbols"), "LSP: [G]et Document [S]ymbols")
    map("n", "gS", fzf_cmd("lsp_workspace_symbols"), "LSP: [G]et Workspace [S]ymbols")
    map("n", "<leader>lD", fzf_cmd("diagnostics_workspace"), "LSP: Workspace [D]iagnostics")
    map("n", "<leader>ld", fzf_cmd("diagnostics_document"), "LSP: Document [D]iagnostics")

    -- LSP Actions
    map("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")
    map("n", "<C-a>", vim.lsp.buf.signature_help, "LSP: Signature Help")
    map({ "n", "x" }, "<leader>ca", fzf_cmd("lsp_code_actions"), "LSP: [C]ode [A]ction")
    map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: [R]ename")

    -- Diagnostics
    map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "LSP: Previous Diagnostic")
    map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "LSP: Next Diagnostic")
end

return M
