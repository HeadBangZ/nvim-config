local is_workstation = os.getenv("NVIM_WORKSTATION_DEV") ~= nil

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
}

if is_workstation then
    vim.lsp.config.csharp_ls = {
        cmd = { "csharp-ls" },
        root_markers = { ".git", ".sln", ".csproj" },
        settings = {
            csharp = {
                enableFormatting = true,
                enableImportCompletion = true,
            },
        },
    }

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
    }

    vim.lsp.enable("csharp_ls")
    vim.lsp.enable("pyright")
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
    }

    vim.lsp.enable("clangd")
    vim.lsp.enable("rust_analyzer")
end

vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
