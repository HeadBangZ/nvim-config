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
        requires = { "williamboman/mason.nvim" },
        opts = function()
            local status, servers = pcall(require, "core.lsp.servers")
            if not status then
                return { ensure_installed = {} }
            end

            local is_workstation = os.getenv("NVIM_WORKSTATION") ~= nil

            local ensure_installed = {}
            local function add_server_names(server_group)
                for name, _ in pairs(server_group) do
                    if name ~= "intelephense" then
                        table.insert(ensure_installed, name)
                    end
                end
            end

            add_server_names(servers.common)

            if is_workstation then
                add_server_names(servers.workstation)
            else
                add_server_names(servers.systems)
            end

            return {
                ensure_installed = ensure_installed,
                automatic_installation = true,
            }
        end,
    },
}
