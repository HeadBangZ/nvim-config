require("config.themes.builder").load("zenbones")

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "zenbones"

-- Custom Zenbones Palette (Low Saturation, Muted Earth Tones)
local palette = {
    bg       = "NONE",    -- Transparent for terminal integration
    bg_alt   = "#262322", -- Selection, Pmenu, Statusline
    bg_float = "#211e1c", -- Floating windows, diagnostics

    fg       = "#b4b0ab", -- Main foreground (Soft light gray)
    muted    = "#8c8780", -- Comments, subtle UI
    dim      = "#44403e", -- Indent lines, borders, grid marks

    warm     = "#c68a7b", -- Strings, special values (Rosy wood)
    cool     = "#8ba4b0", -- Functions, links, keywords (Slate blue)
    green    = "#879a7f", -- Diff add, success, constants (Muted sage)
    yellow   = "#c3a472", -- Warnings, types (Muted amber)
    red      = "#bb6a68", -- Errors, deleted lines (Soft rose red)
}

_G.ZenbonesPalette = palette

local set_hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-------------------------------------------------------------------------------
-- 1. Native Neovim UI Highlights
-------------------------------------------------------------------------------
set_hl("Normal", { fg = palette.fg, bg = palette.bg })
set_hl("NormalFloat", { fg = palette.fg, bg = "NONE" })
set_hl("FloatBorder", { fg = palette.dim, bg = "NONE" })
set_hl("FloatTitle", { fg = palette.cool, bg = "NONE", bold = true })
set_hl("ColorColumn", { bg = palette.bg_alt })
set_hl("CursorLine", { bg = palette.bg_alt })
set_hl("CursorColumn", { bg = palette.bg_alt })
set_hl("LineNr", { fg = palette.dim })
set_hl("CursorLineNr", { fg = palette.fg, bold = true })
set_hl("SignColumn", { bg = palette.bg })
set_hl("VertSplit", { fg = palette.dim, bg = palette.bg })
set_hl("WinSeparator", { fg = palette.dim, bg = palette.bg })
set_hl("Visual", { bg = palette.bg_alt })
set_hl("Search", { fg = palette.bg_alt, bg = palette.yellow })
set_hl("IncSearch", { fg = palette.bg_alt, bg = palette.warm })
set_hl("StatusLine", { fg = palette.fg, bg = palette.bg_alt })
set_hl("StatusLineNC", { fg = palette.muted, bg = palette.bg })

-- Popup Menus
set_hl("Pmenu", { fg = palette.fg, bg = palette.bg_alt })
set_hl("PmenuSel", { fg = palette.bg_alt, bg = palette.cool, bold = true })
set_hl("PmenuSbar", { bg = palette.bg_alt })
set_hl("PmenuThumb", { bg = palette.dim })

-- Indent Lines & Whitespace
set_hl("Whitespace", { fg = palette.dim })
set_hl("NonText", { fg = palette.dim })

-------------------------------------------------------------------------------
-- 2. Standard Syntax Highlights
-------------------------------------------------------------------------------
set_hl("Comment", { fg = palette.muted, italic = true })
set_hl("Constant", { fg = palette.green })
set_hl("String", { fg = palette.warm })
set_hl("Character", { fg = palette.warm })
set_hl("Number", { fg = palette.fg })
set_hl("Boolean", { fg = palette.warm, bold = true })
set_hl("Float", { fg = palette.fg })

set_hl("Identifier", { fg = palette.fg })
set_hl("Function", { fg = palette.cool })

set_hl("Statement", { fg = palette.fg, bold = true })
set_hl("Conditional", { fg = palette.fg, bold = true })
set_hl("Repeat", { fg = palette.fg, bold = true })
set_hl("Label", { fg = palette.cool })
set_hl("Operator", { fg = palette.muted })
set_hl("Keyword", { fg = palette.cool, bold = true })
set_hl("Exception", { fg = palette.red, bold = true })

set_hl("PreProc", { fg = palette.muted })
set_hl("Include", { fg = palette.cool })
set_hl("Define", { fg = palette.cool })
set_hl("Macro", { fg = palette.cool })

set_hl("Type", { fg = palette.fg, bold = true })
set_hl("StorageClass", { fg = palette.cool })
set_hl("Structure", { fg = palette.cool })
set_hl("Typedef", { fg = palette.cool })

set_hl("Special", { fg = palette.warm })
set_hl("SpecialChar", { fg = palette.warm })
set_hl("Tag", { fg = palette.cool })
set_hl("Delimiter", { fg = palette.muted })
set_hl("SpecialComment", { fg = palette.muted, bold = true })
set_hl("Debug", { fg = palette.red })

set_hl("Underlined", { underline = true })
set_hl("Bold", { bold = true })
set_hl("Italic", { italic = true })

set_hl("Error", { fg = palette.red, bold = true })
set_hl("Todo", { fg = palette.bg_alt, bg = palette.warm, bold = true })

-------------------------------------------------------------------------------
-- 3. Modern Treesitter & LSP Diagnostics
-------------------------------------------------------------------------------
set_hl("@comment", { link = "Comment" })
set_hl("@variable", { fg = palette.fg })
set_hl("@variable.builtin", { fg = palette.cool, italic = true })
set_hl("@function", { link = "Function" })
set_hl("@function.builtin", { fg = palette.cool, bold = true })
set_hl("@keyword", { link = "Keyword" })
set_hl("@string", { link = "String" })
set_hl("@number", { link = "Number" })
set_hl("@type", { link = "Type" })
set_hl("@punctuation.bracket", { fg = palette.muted })
set_hl("@punctuation.delimiter", { fg = palette.muted })
set_hl("@property", { fg = palette.fg })

set_hl("DiagnosticError", { fg = palette.red })
set_hl("DiagnosticWarn", { fg = palette.yellow })
set_hl("DiagnosticInfo", { fg = palette.cool })
set_hl("DiagnosticHint", { fg = palette.muted })

-------------------------------------------------------------------------------
-- 4. Active Plugin Integrations
-------------------------------------------------------------------------------

-- oil.nvim
set_hl("OilDir", { fg = palette.cool, bold = true })
set_hl("OilDirIcon", { fg = palette.cool })
set_hl("OilFile", { fg = palette.fg })
set_hl("OilLink", { fg = palette.warm, underline = true })
set_hl("OilLinkTarget", { fg = palette.muted })
set_hl("OilCopy", { fg = palette.yellow })
set_hl("OilMove", { fg = palette.yellow })
set_hl("OilPurge", { fg = palette.red })
set_hl("OilCreate", { fg = palette.green })
set_hl("OilDelete", { fg = palette.red })
set_hl("OilPermission", { fg = palette.muted })
set_hl("OilSize", { fg = palette.muted })
set_hl("OilMtime", { fg = palette.muted })

-- fzf-lua (Transparent)
set_hl("FzfLuaNormal", { fg = palette.fg, bg = "NONE" })
set_hl("FzfLuaBorder", { fg = palette.dim, bg = "NONE" })
set_hl("FzfLuaTitle", { fg = palette.cool, bg = "NONE", bold = true })
set_hl("FzfLuaBackdrop", { bg = "NONE" })
set_hl("FzfLuaCursorLine", { bg = palette.bg_alt })
set_hl("FzfLuaMatch", { fg = palette.warm, bold = true })
set_hl("FzfLuaFzfMatch", { fg = palette.warm, bold = true })
set_hl("FzfLuaFzfPointer", { fg = palette.cool })
set_hl("FzfLuaHeader", { fg = palette.cool })
set_hl("FzfLuaScrollBorder", { fg = palette.dim })

-- gitsigns.nvim
set_hl("GitSignsAdd", { fg = palette.green, bg = palette.bg })
set_hl("GitSignsChange", { fg = palette.yellow, bg = palette.bg })
set_hl("GitSignsDelete", { fg = palette.red, bg = palette.bg })
set_hl("GitSignsChangedelete", { fg = palette.yellow, bg = palette.bg })
set_hl("GitSignsTopdelete", { fg = palette.red, bg = palette.bg })
set_hl("GitSignsUntracked", { fg = palette.muted, bg = palette.bg })
set_hl("GitSignsAddInline", { bg = "#253325" })
set_hl("GitSignsChangeInline", { bg = "#383324" })
set_hl("GitSignsDeleteInline", { bg = "#3d2424" })
set_hl("GitSignsCurrentLineBlame", { fg = palette.muted, italic = true })

-- blink.cmp (Transparent)
set_hl("BlinkCmpMenu", { fg = palette.fg, bg = "NONE" })
set_hl("BlinkCmpMenuBorder", { fg = palette.dim, bg = "NONE" })
set_hl("BlinkCmpSelection", { fg = palette.fg, bg = palette.bg_alt, bold = true })
set_hl("BlinkCmpLabel", { fg = palette.fg })
set_hl("BlinkCmpLabelDeprecated", { fg = palette.muted, strikethrough = true })
set_hl("BlinkCmpLabelMatch", { fg = palette.warm, bold = true })
set_hl("BlinkCmpDoc", { fg = palette.fg, bg = "NONE" })
set_hl("BlinkCmpDocBorder", { fg = palette.dim, bg = "NONE" })
set_hl("BlinkCmpKind", { fg = palette.cool })

-- Built-in Diffs, Diffview & Neogit
set_hl("DiffAdd", { bg = "#253325" })
set_hl("DiffChange", { bg = "#383324" })
set_hl("DiffDelete", { fg = palette.muted, bg = "#3d2424" })
set_hl("DiffText", { bg = "#4a3f25", bold = true })

set_hl("DiffviewFilePanelTitle", { fg = palette.cool, bold = true })
set_hl("DiffviewFilePanelCounter", { fg = palette.warm, bold = true })
set_hl("DiffviewFilePanelFileName", { fg = palette.fg })
set_hl("DiffviewFolderName", { fg = palette.muted })

set_hl("NeogitBranch", { fg = palette.cool, bold = true })
set_hl("NeogitRemote", { fg = palette.warm })
set_hl("NeogitHunkHeader", { fg = palette.fg, bg = palette.bg_alt, bold = true })
set_hl("NeogitHunkHeaderHighlight", { fg = palette.cool, bg = palette.bg_alt, bold = true })
set_hl("NeogitDiffAddHighlight", { bg = "#253325" })
set_hl("NeogitDiffDeleteHighlight", { bg = "#3d2424" })

-- Extras
set_hl("HighlightColorsInline", { bold = true })
