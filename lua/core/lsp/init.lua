local keymaps = require("core.lsp.keymaps")
local servers = require("core.lsp.servers")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

local function setup_servers(server_name, config)
    config.on_attach = keymaps.on_attach
    config.capabilities = capabilities

    vim.lsp.config[server_name] = config
    vim.lsp.enable(server_name)
end

vim.lsp.config("*", {
    root_markers = { ".git" },
})

for name, config in pairs(servers.common) do
    setup_servers(name, config)
end

local is_workstation = os.getenv("NVIM_WORKSTATION_DEV") ~= nil

if is_workstation then
    for name, config in pairs(servers.workstation) do
        setup_servers(name, config)
    end
else
    for name, config in pairs(servers.systems) do
        setup_servers(name, config)
    end
end
