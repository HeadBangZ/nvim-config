return {
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "ojroques/vim-oscyank",
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end
    },
    {
        "mbbill/undotree",
    },
    {
        "tpope/vim-surround",
        event = "VeryLazy"
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy"
    }
}
