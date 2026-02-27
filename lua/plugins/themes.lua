local active_theme = "darkvoid"

local themes = {
    kanagawa = "rebelot/kanagawa.nvim",
    everforest = "sainnhe/everforest",
    ["rose-pine"] = "rose-pine/neovim",
    darkvoid = "aliqyan-21/darkvoid.nvim"
}

local plugins = {}

for theme, repo in pairs(themes) do
    if theme == active_theme then
        table.insert(plugins, {
            repo,
            lazy = false,
            priority = 1000,
            config = function()
                if theme == "everforest" then
                    vim.g.everforest_transparent_background = 1
                elseif theme == "rose-pine" then
                    require('rose-pine').setup({
                        styles = {
                            transparency = true,
                        },
                    })
                end

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
