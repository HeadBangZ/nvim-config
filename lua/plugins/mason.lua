return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        requires = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "gopls",
                    "csharp_ls",
                    "lua_ls",
                    "clangd",
                    "rust_analyzer",
                    "ols",
                },   
            })
        end,
    },
}
