return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag"
    },
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
            autotag = { enable = true },
            auto_install = false,
            ensure_installed = {
                -- System / Low Level
                "c",
                "rust",
                "go",
                "odin",
                "zig",
                "nim",

                -- Scripting / Config
                "lua",
                "python",
                "bash",
                "regex",
                "dockerfile",

                -- Web Development
                "php",
                "html",
                "css",
                "scss",
                "javascript",
                "typescript",

                -- Data Formats
                "json",
                "toml",
                "yaml",
                "csv",
                "helm",

                -- Documentation
                "markdown",
                "markdown_inline",
                "vim",
                "vimdoc"
            },
        })
    end
}
