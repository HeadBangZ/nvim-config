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

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

local ok_tag, autotag = pcall(require, "nvim-ts-autotag")
if ok_tag then
    autotag.setup({})
end
