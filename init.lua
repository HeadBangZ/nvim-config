-- init.lua
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
    { src = "https://github.com/mbbill/undotree" },
    { src = "https://github.com/junegunn/fzf.vim" },
})

require("config")
require("core.lsp")
require("plugins")

-- Core logic
-- require("terminal")
-- require("lazy")
-- require("autocmd")
-- require("grep")
-- require("lsp")
-- vim.lsp.set_log_level("debug")
