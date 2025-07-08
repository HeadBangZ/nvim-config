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
        config = function()
            -- 1. Define the arrow statusline component.
            local arrow_status = {
                function()
                    -- This function safely gets the statusline text from arrow.nvim
                    local success, statusline = pcall(require, "arrow.statusline")
                    if success then
                        return statusline.text_for_statusline_with_icons()
                    else
                        return "" -- Return empty string if arrow is not loaded
                    end
                end,
                padding = { left = 1, right = 1 },
            }

            -- 2. Setup lualine with the new component.
            require("lualine").setup({
                options = {
                    theme = "kanagawa",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff" },
                    lualine_c = { "filename", arrow_status }, -- Added the component here
                    lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
}
