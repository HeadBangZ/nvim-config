local status_m, mason = pcall(require, "mason")
local status_ml, mason_lspconfig = pcall(require, "mason-lspconfig")
local status_s, servers = pcall(require, "core.lsp.servers")

if not (status_m and status_ml and status_s) then
    return
end

local is_workstation = os.getenv("NVIM_WORKSTATION") ~= nil
local ensure_installed = {}

local function add_to_list(server_group)
    for name, _ in pairs(server_group) do
        if name ~= "nimlangserver" then
            table.insert(ensure_installed, name)
        end
    end
end

add_to_list(servers.common)

if is_workstation then
    add_to_list(servers.workstation)
else
    add_to_list(servers.systems)
end

mason.setup()
mason_lspconfig.setup({
    ensure_installed = ensure_installed,
    automatic_installation = true,
})
