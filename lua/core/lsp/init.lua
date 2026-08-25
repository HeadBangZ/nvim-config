require("core.lsp.filetypes")

local keymaps = require("core.lsp.keymaps")
local servers = require("core.lsp.servers")

local function get_capabilities(custom_capabilities)
    local capabilities = custom_capabilities or vim.lsp.protocol.make_client_capabilities()

    local ok, blink = pcall(require, "blink.cmp")
    if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
    end

    capabilities.workspace = capabilities.workspace or {}
    capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = true }

    return capabilities
end

local function setup_servers(server_name, config)
    local final_config = vim.tbl_deep_extend("force", {
        on_attach = keymaps.on_attach,
        capabilities = get_capabilities(config.capabilities)
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

for name, config in pairs(servers.workstation) do
    setup_servers(name, config)
end
