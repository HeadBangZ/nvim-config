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
        config = function()
            vim.cmd.colorscheme "kanagawa"
            enable_transparency()
        end
    },
    {
        "morhetz/gruvbox",
    },
    {
        "sainnhe/everforest",
    },
    -- End
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "kanagawa"
        }
    },
}
