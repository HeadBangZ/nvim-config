-- init.lua
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")
vim.loader.enable()

-- Native plugins
vim.pack.add({
    -- themes
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/sainnhe/everforest" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/aliqyan-21/darkvoid.nvim" },
    { src = "https://github.com/datsfilipe/vesper.nvim" },

    -- plugins
    { src = "https://github.com/nvim-treesitter/nvim-treesitter",   branch = "main" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/otavioschwanck/arrow.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/junegunn/fzf.vim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
    { src = "https://github.com/kylechui/nvim-surround" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/b0o/schemastore.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
})

require("config")
require("plugins")
require("core.lsp")
