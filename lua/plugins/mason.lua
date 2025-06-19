return {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup()
    end,
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "gopls",
                    "lua_ls",
                    "clangd",
                    "rust_analyzer",
                },   
            })
        end,
    },
}
