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
                "gopls",
                "lua_ls",
            }

            if is_workstation then
                table.insert(ensure_installed_lsps, "pyright")
                table.insert(ensure_installed_lsps, "ts_ls")
                table.insert(ensure_installed_lsps, "cssls")
            else
                table.insert(ensure_installed_lsps, "clangd")
                table.insert(ensure_installed_lsps, "rust_analyzer")
            end

            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed_lsps
            })
        end,
    },
}
