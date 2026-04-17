local theme_name = "vesper"

if not pcall(vim.cmd.colorscheme, theme_name) then
    return
end

local groups = { "Normal", "NormalFloat", "LineNr", "SignColumn", "EndOfBuffer" }
for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

local get_color = function(group, attr)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    local col = hl[attr]
    return col and string.format("#%06x", col) or "#FFFFFF"
end

local theme_accent = get_color("Statement", "bg")
local theme_string = get_color("String", "fg")
local theme_error = get_color("DiagnosticError", "fg")

vim.api.nvim_set_hl(0, "StModeNormal", { fg = "#101010", bg = theme_string, bold = true })
vim.api.nvim_set_hl(0, "StModeTerminal", { fg = "#101010", bg = theme_error, bold = true })
vim.api.nvim_set_hl(0, "LineAndCol", { fg = "#101010", bg = theme_accent, bold = true })
