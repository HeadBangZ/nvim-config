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

vim.lsp.enable("gopls")
--return {
--    vim.enable("gopls")
--    {
--        "neovim/nvim-lspconfig",
--        dependencies = {
--            "hrsh7th/cmp-nvim-lsp",
--            "hrsh7th/nvim-cmp",
--        },
--        config = function()
--            require("lspconfig").lua_ls.setup { }
--            require("lspconfig").gopls.setup {
--                cmd = { "gopls" },
--                root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
--                settings = {
--                    gopls = {
--                        completeUnimported = true,
--                        usePlaceholders = true,
--                        staticcheck = true,
--                        analyses = {
--                            unusedparams = true, 
--                        },
--                    },
--                },
--            }
--        end,
--    }
--cd
