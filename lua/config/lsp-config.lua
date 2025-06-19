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

vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
