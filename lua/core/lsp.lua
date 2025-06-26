local is_workstation = os.getenv("NVIM_WORKSTATION_DEV") ~= nil

local on_attach = function(client, bufnr)
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
    map_buf_key('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map_buf_key('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    map_buf_key('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    map_buf_key("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    map_buf_key("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

vim.lsp.config("*", {
    root_markers = { ".git" },
})

vim.lsp.config.gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
            analyses = {
                unusedParams = true,
            },
        },
    },
    on_attach = on_attach,
}

vim.lsp.config.lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json" },
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath("config") .. "/lua",
                },
            },
            diagnostics = {
                globals = { "vim" },
            },
            completion = {
                callSnippet = "Replace",
            },
            telemetry = {
                enable = false
            },
        },
    },
    on_attach = on_attach,
}

if is_workstation then
    vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                },
            },
        },
        on_attach = on_attach,
    }

    vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        on_attach = on_attach,
    }

    vim.lsp.config.cssls = {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less", },
        root_markers = { "package.json", ".git" },
        settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
            hover = {
                documentation = true,
                references = true,
            },
        },
        on_attach = on_attach,
    }

    vim.lsp.enable("pyright")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("cssls")
else
    vim.lsp.config.clangd = {
        cmd = {
            "clangd",
            "--clang-tidy",
            "--background-index",
            "--offset-encoding=utf-8",
        },
        root_markers = { ".clangd", "compile_commands.json" },
        filetypes = { "c" },
        on_attach = on_attach,
    }

    vim.lsp.config.rust_analyzer = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", ".git" },
        settings = {
            ["rust_analyzer"] = {
                inlayHints = {
                },
            },
            checkOnSave = {
                command = "clippy",
            },
            procMacro = {
                enable = true,
            },
        },
        on_attach = on_attach,
    }

    vim.lsp.config.ols = {
        cmd = { "ols" },
        filetypes = { "odin" },
        root_markers = { "ols.json", ".git" },
        on_attach = on_attach,
    }

    vim.lsp.config.nimlangserver = {
        cmd = { "nimlangserver" },
        filetypes = { "nim" },
        root_markers = { ".git", "nim.nimble", "package.nim", "config.nims" },
        settings = {
            nim = {
                nimsuggestPath = "/usr/bin/nimsuggest",
                nimSearchPaths = {
                    '/usr/lib/nim/lib',
                },
            },
        },
        on_attach = on_attach,
    }

    vim.lsp.enable("clangd")
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("ols")
    vim.lsp.enable("nimlangserver")
end

vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
