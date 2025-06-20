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
            local is_workstation = os.getenv("NVIM_WORKSTATION_DEV") ~= nil

            local ensure_installed_lsps = {
                "clangd",
                "gopls",
                "lua_ls",
                "ols",
                "rust_analyzer",
            }

            if is_workstation then
                table.insert(ensure_installed_lsps, "csharp_ls")
                table.insert(ensure_installed_lsps, "pyright")
            end

            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed_lsps
            })
        end,
    },
}
