local M = {}

function M.groups(c, s)
    return {
        -------------------------------------------------------------------------
        -- UI
        -------------------------------------------------------------------------
        Normal = { fg = c.fg, bg = c.bg },
        NormalFloat = { fg = c.fg, bg = c.bg_float },
        FloatBorder = { fg = c.dim, bg = c.bg_float },
        FloatTitle = { fg = c.accent, bg = c.bg_float, bold = true },
        ColorColumn = { bg = c.bg_alt },
        CursorLine = { bg = c.bg_alt },
        CursorColumn = { bg = c.bg_alt },
        LineNr = { fg = c.dim },
        CursorLineNr = { fg = c.fg, bold = true },
        SignColumn = { bg = c.bg },
        WinSeparator = { fg = c.dim, bg = c.bg },
        VertSplit = { link = "WinSeparator" },
        Visual = { bg = c.bg_alt },
        Search = { fg = c.on_accent, bg = c.warn },
        IncSearch = { fg = c.on_accent, bg = c.inc_search or c.accent },
        StatusLine = { fg = c.fg, bg = c.bg_alt },
        StatusLineNC = { fg = c.muted, bg = c.bg },
        Pmenu = { fg = c.fg, bg = c.bg_alt },
        PmenuSel = { fg = c.bg_alt, bg = c.accent, bold = true },
        PmenuSbar = { bg = c.bg_alt },
        PmenuThumb = { bg = c.dim },
        Whitespace = { fg = c.dim },
        NonText = { fg = c.dim },

        -------------------------------------------------------------------------
        -- Syntax
        -------------------------------------------------------------------------
        Comment = { fg = c.muted, italic = s.italic_comments },
        Constant = { fg = c.constant },
        String = { fg = c.string },
        Character = { link = "String" },
        Number = { fg = c.number or c.constant },
        Float = { link = "Number" },
        Boolean = { fg = c.boolean or c.constant, bold = true },

        Identifier = { fg = c.fg },
        Function = { fg = c.func },

        Statement = { fg = c.statement or c.accent, bold = true },
        Conditional = { link = "Statement" },
        Repeat = { link = "Statement" },
        Label = { fg = c.accent },
        Operator = { fg = c.operator or c.fg },
        Keyword = { fg = c.accent, bold = true, italic = s.italic_keywords },
        Exception = { fg = c.error, bold = true },

        PreProc = { fg = c.preproc or c.type },
        Include = { fg = c.include or c.preproc or c.type },
        Define = { link = "Include" },
        Macro = { link = "Include" },

        Type = { fg = c.type, bold = true },
        StorageClass = { fg = c.type_decl or c.type },
        Structure = { link = "StorageClass" },
        Typedef = { link = "StorageClass" },

        Special = { fg = c.special or c.constant },
        SpecialChar = { link = "Special" },
        Tag = { fg = c.accent },
        Delimiter = { fg = c.delimiter or c.muted },
        SpecialComment = { fg = c.muted, bold = true },
        Debug = { fg = c.error },

        Underlined = { underline = true },
        Bold = { bold = true },
        Italic = { italic = true },
        Error = { fg = c.error, bold = true },
        Todo = { fg = c.on_accent, bg = c.todo or c.warn, bold = true },

        -------------------------------------------------------------------------
        -- Treesitter
        -------------------------------------------------------------------------
        ["@comment"] = { link = "Comment" },
        ["@variable"] = { fg = c.fg },
        ["@variable.builtin"] = { fg = c.builtin or c.fg, italic = true },
        ["@function"] = { link = "Function" },
        ["@function.call"] = { link = "Function" },
        ["@function.builtin"] = { fg = c.func, bold = true },
        ["@keyword"] = { link = "Keyword" },
        ["@keyword.return"] = { link = "Keyword" },
        ["@string"] = { link = "String" },
        ["@number"] = { link = "Number" },
        ["@boolean"] = { link = "Boolean" },
        ["@type"] = { link = "Type" },
        ["@type.builtin"] = { fg = c.type },
        ["@property"] = { fg = c.fg },
        ["@punctuation.bracket"] = { fg = c.bracket or c.muted },
        ["@punctuation.delimiter"] = { fg = c.delimiter or c.muted },

        -------------------------------------------------------------------------
        -- Diagnostics & diffs
        -------------------------------------------------------------------------
        DiagnosticError = { fg = c.error },
        DiagnosticWarn = { fg = c.warn },
        DiagnosticInfo = { fg = c.info },
        DiagnosticHint = { fg = c.hint },

        DiffAdd = { bg = c.diff_add },
        DiffChange = { bg = c.diff_change },
        DiffDelete = { fg = c.dim, bg = c.diff_delete },
        DiffText = { bg = c.diff_text, bold = true },

        -------------------------------------------------------------------------
        -- Plugins
        -------------------------------------------------------------------------
        -- oil.nvim
        OilDir = { fg = c.accent, bold = true },
        OilDirIcon = { fg = c.accent },
        OilFile = { fg = c.fg },
        OilLink = { fg = c.string, underline = true },
        OilLinkTarget = { fg = c.muted },
        OilCopy = { fg = c.warn },
        OilMove = { fg = c.warn },
        OilPurge = { fg = c.error },
        OilCreate = { fg = c.add },
        OilDelete = { fg = c.error },
        OilPermission = { fg = c.muted },
        OilSize = { fg = c.muted },
        OilMtime = { fg = c.muted },

        -- fzf-lua
        FzfLuaNormal = { fg = c.fg, bg = c.bg_float },
        FzfLuaBorder = { fg = c.dim, bg = c.bg_float },
        FzfLuaTitle = { fg = c.accent, bg = c.bg_float, bold = true },
        FzfLuaBackdrop = { bg = c.bg_float },
        FzfLuaCursorLine = { bg = c.bg_alt },
        FzfLuaMatch = { fg = c.match or c.accent, bold = true },
        FzfLuaFzfMatch = { link = "FzfLuaMatch" },
        FzfLuaFzfPointer = { fg = c.accent },
        FzfLuaHeader = { fg = c.accent },
        FzfLuaScrollBorder = { fg = c.dim },

        -- blink.cmp
        BlinkCmpMenu = { fg = c.fg, bg = c.bg_float },
        BlinkCmpMenuBorder = { fg = c.dim, bg = c.bg_float },
        BlinkCmpSelection = { fg = c.fg, bg = c.bg_alt, bold = true },
        BlinkCmpLabel = { fg = c.fg },
        BlinkCmpLabelDeprecated = { fg = c.muted, strikethrough = true },
        BlinkCmpLabelMatch = { link = "FzfLuaMatch" },
        BlinkCmpDoc = { fg = c.fg, bg = c.bg_float },
        BlinkCmpDocBorder = { fg = c.dim, bg = c.bg_float },
        BlinkCmpKind = { fg = c.kind or c.accent },

        -- gitsigns.nvim
        GitSignsAdd = { fg = c.add, bg = c.bg },
        GitSignsChange = { fg = c.warn, bg = c.bg },
        GitSignsDelete = { fg = c.error, bg = c.bg },
        GitSignsChangedelete = { link = "GitSignsChange" },
        GitSignsTopdelete = { link = "GitSignsDelete" },
        GitSignsUntracked = { fg = c.muted, bg = c.bg },
        GitSignsAddInline = { bg = c.diff_add },
        GitSignsChangeInline = { bg = c.diff_change },
        GitSignsDeleteInline = { bg = c.diff_delete },
        GitSignsCurrentLineBlame = { fg = c.muted, italic = true },

        -- diffview / neogit
        DiffviewFilePanelTitle = { fg = c.accent, bold = true },
        DiffviewFilePanelCounter = { fg = c.string, bold = true },
        DiffviewFilePanelFileName = { fg = c.fg },
        DiffviewFolderName = { fg = c.muted },
        NeogitBranch = { fg = c.accent, bold = true },
        NeogitRemote = { fg = c.string },
        NeogitHunkHeader = { fg = c.fg, bg = c.bg_alt, bold = true },
        NeogitHunkHeaderHighlight = { fg = c.accent, bg = c.bg_alt, bold = true },
        NeogitDiffAddHighlight = { bg = c.diff_add },
        NeogitDiffDeleteHighlight = { bg = c.diff_delete },

        -- nvim-highlight-colors
        HighlightColorsInline = { bold = true },
    }
end

function M.terminal(c)
    local ansi = { c.bg_alt, c.error, c.add, c.warn, c.func, c.string, c.accent, c.fg }
    for i, color in ipairs(ansi) do
        vim.g["terminal_color_" .. (i - 1)] = color
        vim.g["terminal_color_" .. (i + 7)] = color
    end
end

function M.load(name)
    local module = "config.themes.palettes." .. name
    package.loaded[module] = nil
    local spec = require(module)
    local settings = require("config.themes").settings

    vim.cmd("highlight clear")
    if vim.g.syntax_on then
        vim.cmd("syntax reset")
    end
    vim.o.background = spec.background or "dark"
    vim.g.colors_name = name

    local c = vim.deepcopy(spec.colors)
    if settings.transparent then
        c.bg, c.bg_float = "NONE", "NONE"
    end

    local groups = M.groups(c, settings)
    if spec.overrides then
        groups = vim.tbl_extend("force", groups, spec.overrides(c, settings))
    end

    for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end
    M.terminal(c)
end

return M
