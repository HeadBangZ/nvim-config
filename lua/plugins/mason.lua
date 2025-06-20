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
                    "clangd",
                    "csharp_ls",
                    "gopls",
                    "lua_ls",
                    "ols",
                    "pyright",
                    "rust_analyzer",
                },
            })
        end,
    },
}
