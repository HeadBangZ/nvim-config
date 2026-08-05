local theme_name = "poimandres"

local ok_sub, theme_config = pcall(require, "core.themes." .. theme_name)
if ok_sub and type(theme_config.setup) == "function" then
    theme_config.setup()
end

if not pcall(vim.cmd.colorscheme, theme_name) then
    return
end

local groups = { "Normal", "NormalFloat", "LineNr", "SignColumn", "EndOfBuffer" }
for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

local get_color     = function(group, attr)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    local col = hl[attr]
    return col and string.format("#%06x", col) or "#FFFFFF"
end

local theme_string  = get_color("String", "fg") or "#a6e3a1"
local theme_func    = get_color("Function", "fg") or "#89b4fa"
local theme_accent  = get_color("Statement", "fg") or "#f9e2af"
local theme_special = get_color("Type", "fg") or "#fab387"

vim.api.nvim_set_hl(0, "StModeNormal", { fg = "#101010", bg = theme_string, bold = true })
vim.api.nvim_set_hl(0, "StModeCommand", { fg = "#101010", bg = theme_func, bold = true })
vim.api.nvim_set_hl(0, "StModeTerminal", { fg = "#101010", bg = theme_special, bold = true })
vim.api.nvim_set_hl(0, "LineAndCol", { fg = "#101010", bg = theme_accent, bold = true })

vim.api.nvim_set_hl(0, "NotifyText", { fg = "#e0e0e0", bold = false })
vim.api.nvim_set_hl(0, "NotifySuccess", { fg = "#78ccc6", bold = true })
vim.api.nvim_set_hl(0, "NotifyInfo", { fg = "#78a9ff", bold = false })
