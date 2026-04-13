-- init.lua
vim.loader.enable()
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")

vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main"
    },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/datsfilipe/vesper.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/rcarriga/nvim-notify" },
})

require("config")
require("core")

vim.schedule(function()
    vim.pack.add({
        {
            src = "https://github.com/Saghen/blink.cmp",
            branch = "main"
        },
        { src = "https://github.com/L3MON4D3/LuaSnip" },
        { src = "https://github.com/rafamadriz/friendly-snippets" },
        { src = "https://github.com/ibhagwan/fzf-lua" },
        { src = "https://github.com/stevearc/oil.nvim" },
        { src = "https://github.com/lewis6991/gitsigns.nvim" },
        { src = "https://github.com/folke/which-key.nvim" },
        { src = "https://github.com/tpope/vim-fugitive" },
        { src = "https://github.com/otavioschwanck/arrow.nvim" },
        { src = "https://github.com/b0o/schemastore.nvim" },
        { src = "https://github.com/folke/todo-comments.nvim" },
        { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
        { src = "https://github.com/windwp/nvim-autopairs" },
        { src = "https://github.com/kylechui/nvim-surround" },
    })

    require("core.lsp")
    require("plugins")
end)
