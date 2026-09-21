local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
    return
end

local parsers = {
    "query",

    -- System / Low Level
    "c",
    "rust",
    "go",
    "odin",
    "zig",
    "nim",

    -- General Purpose
    "c_sharp",
    "julia",

    -- Functional
    "elixir",
    "heex",
    "eex",
    "erlang",

    -- Scripting / Config
    "lua",
    "python",
    "bash",

    -- Cloud Native & IaC
    "helm",
    "dockerfile",
    "terraform",
    "hcl",

    -- Web Development
    "php",
    "html",
    "css",
    "scss",
    "javascript",
    "typescript",

    -- Data Formats & Storage
    "json",
    "toml",
    "sql",
    "csv",
    "yaml",

    -- Documentation & Git
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "gitignore",

    -- Shared
    "regex",
}

local installed = require("nvim-treesitter.config").get_installed()
local to_install = {}

for _, p in ipairs(parsers) do
    if not vim.tbl_contains(installed, p) then
        table.insert(to_install, p)
    end
end

if #to_install > 0 then
    ts.install(to_install)
end

local update_interval_days = 7
local last_update_file = vim.fs.joinpath(vim.fn.stdpath("state"), "ts_last_update")

local function mark_updated()
    local f = io.open(last_update_file, "w")
    if f then
        f:write(tostring(os.time()))
        f:close()
    end
end

local function update_is_due()
    local f = io.open(last_update_file, "r")
    if not f then
        return true
    end

    local last = tonumber(f:read("*a"))
    f:close()

    return not last or (os.time() - last) > (update_interval_days * 24 * 60 * 60)
end

vim.api.nvim_create_user_command("TSUpdateCheck", function()
    ts.update()
    mark_updated()
end, { desc = "Treesitter: check installed parsers for updates" })

if update_is_due() then
    ts.update()
    mark_updated()
end

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
