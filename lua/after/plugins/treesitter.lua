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
                "c_sharp",
                "rust",
                "odin",
                "lua",
                "python",
                "json",
                "yaml",
                "markdown",
                "csv",
                "javascript",
                "typescript",
            },
            auto_install = false,
        })
    end
}
