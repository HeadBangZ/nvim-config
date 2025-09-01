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
            local arrow_status = {
                function()
                    local success, statusline = pcall(require, "arrow.statusline")
                    if success then
                        return statusline.text_for_statusline_with_icons()
                    end
                end,
                padding = { left = 1, right = 1 },
            }

            require("lualine").setup({
                options = {
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff" },
                    lualine_c = { "filename", arrow_status },
                    lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
}
