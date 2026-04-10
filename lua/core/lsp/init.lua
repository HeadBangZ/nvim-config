local keymaps = require("core.lsp.keymaps")
local servers = require("core.lsp.servers")

local function setup_servers(server_name, config)
    local server_capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

    server_capabilities.workspace = server_capabilities.workspace or {}
    server_capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = true }

    local final_config = vim.tbl_deep_extend("force", {
        on_attach = keymaps.on_attach,
        capabilities = server_capabilities
    }, config)

    vim.lsp.config(server_name, final_config)
    vim.lsp.enable(server_name)
end

vim.lsp.config("*", {
    root_markers = { ".git" },
})

for name, config in pairs(servers.common) do
    setup_servers(name, config)
end

local is_workstation = os.getenv("NVIM_WORKSTATION") ~= nil

if is_workstation then
    for name, config in pairs(servers.workstation) do
        setup_servers(name, config)
    end
else
    for name, config in pairs(servers.systems) do
        setup_servers(name, config)
    end
end
