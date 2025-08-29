return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {
                enable = true
            },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "c",
                "go",
                "rust",
                "odin",
                "nim",
                "lua",
                "python",
                "json",
                "toml",
                "yaml",
                "markdown",
                "csv",
                "javascript",
                "typescript",
                "vim",
                "vimdoc",
            },
            auto_install = false,
        })
    end
}
