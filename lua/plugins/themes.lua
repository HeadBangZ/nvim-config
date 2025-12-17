local active_theme = "kanagawa"

local themes = {
    kanagawa = "rebelot/kanagawa.nvim",
    tokyonight = "folke/tokyonight.nvim",
    gruvbox = "morhetz/gruvbox",
    everforest = "sainnhe/everforest",
}

local plugins = {}

for theme, repo in pairs(themes) do
    if theme == active_theme then
        table.insert(plugins, {
            repo,
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd.colorscheme(theme)

                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end,
        })
    else
        table.insert(plugins, { repo })
    end
end

return plugins
