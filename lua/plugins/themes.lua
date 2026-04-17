local active_theme = "vesper"

if active_theme == "everforest" then
    vim.g.everforest_transparent_background = 1
elseif active_theme == "rose-pine" then
    local ok, rose_pine = pcall(require, "rose-pine")
    if ok then
        rose_pine.setup({ styles = { transparency = true } })
    end
elseif active_theme == "vesper" then
    local ok, vesper = pcall(require, "vesper")
    if ok then
        vesper.setup({ transparent = true })
    end
end

local ok_scheme, _ = pcall(vim.cmd.colorscheme, active_theme)

if ok_scheme then
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    -- TODO: make it dynamic to the active theme
    local bg    = "#101010"
    local peach = "#FFC799"
    local green = "#99FFE4"
    local white = "#FFFFFF"
    local red   = "#FF8080"

    vim.cmd(string.format('highlight! Search guifg=%s guibg=%s gui=bold', bg, peach))
    vim.cmd(string.format('highlight! StModeNormal guifg=%s guibg=%s gui=bold', bg, peach))
    vim.cmd(string.format('highlight! StModeInsert guifg=%s guibg=%s gui=bold', bg, green))
    vim.cmd(string.format('highlight! StModeVisual guifg=%s guibg=%s gui=bold', bg, white))
    vim.cmd(string.format('highlight! StPosition   guifg=%s guibg=%s gui=bold', bg, peach))
    vim.cmd(string.format('highlight! StModeTerminal guifg=%s guibg=%s gui=bold', bg, red))
else
    print("Theme not found: " .. active_theme)
end
