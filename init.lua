-- init.lua
vim.loader.enable()
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")

vim.pack.add({
    -- { src = "https://github.com/slugbyte/lackluster.nvim" },
    -- { src = "https://github.com/datsfilipe/vesper.nvim" },
    { src = "https://github.com/olivercederborg/poimandres.nvim" },
})

require("config")
require("core")

vim.schedule(function()
    vim.pack.add({
        {
            src = "https://github.com/nvim-treesitter/nvim-treesitter",
            branch = "main"
        },
        { src = "https://github.com/Saghen/blink.lib" },
        {
            src = "https://github.com/Saghen/blink.cmp",
            branch = "main",
        },
        { src = "https://github.com/nvim-tree/nvim-web-devicons" },
        { src = "https://github.com/rafamadriz/friendly-snippets" },
        { src = "https://github.com/ibhagwan/fzf-lua" },
        { src = "https://github.com/stevearc/oil.nvim" },
        { src = "https://github.com/sindrets/diffview.nvim" },
        { src = "https://github.com/lewis6991/gitsigns.nvim" },
        -- { src = "https://github.com/tpope/vim-fugitive" },
        { src = "https://github.com/NeogitOrg/neogit" },
        { src = "https://github.com/echasnovski/mini.pairs" },
        { src = "https://github.com/b0o/schemastore.nvim" },
        { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
        { src = "https://github.com/kylechui/nvim-surround" },
    })

    -- require("core.lsp")
    require("plugins")
    require("custom")
end)

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        require("core.lsp")
    end,
})
