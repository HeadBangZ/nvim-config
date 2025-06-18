local function enable_transparency()
    vim.api.nvim_set_hl(0, "normal", { bg = "none" })
end

return {
    -- Colors
    {
        "folke/tokyonight.nvim",
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "morhetz/gruvbox",
    },
    {
        "sainnhe/everforest",
        config = function()
            vim.cmd.colorscheme "everforest"
            enable_transparency()
        end
    },
    -- End
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "everforest"
        }
    },
}
