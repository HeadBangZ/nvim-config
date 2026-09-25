local p = {
    bg       = "#000000",
    bg_alt   = "#242830",
    bg_float = "#1e1e1e",
    fg       = "#d4d4d4",
    comment  = "#78808c",
    dim      = "#525866",
    cyan     = "#5c9dad",
    slate    = "#738bb5",
    rose     = "#ba8ba4",
    sage     = "#5a9e87",
    teal     = "#589ba8",
    red      = "#b86363",
    amber    = "#b8965a",
}

return {
    colors = {
        bg = p.bg,
        bg_alt = p.bg_alt,
        bg_float = p.bg_float,
        fg = p.fg,
        muted = p.comment,
        dim = p.dim,
        on_accent = "#000000",

        accent = p.cyan,
        func = p.rose,
        string = p.slate,
        type = p.sage,
        constant = p.teal,
        error = p.red,
        warn = p.amber,
        info = p.cyan,
        hint = p.comment,
        add = p.sage,

        bracket = p.fg,
        delimiter = p.dim,
        kind = p.sage,

        diff_add = "#1e332a",
        diff_change = "#332c1e",
        diff_delete = "#331e1e",
        diff_text = "#40351e",
    },
    overrides = function(c)
        return {
            OilLink = { fg = c.type, italic = true },
            NeogitBranch = { fg = c.func, bold = true },
        }
    end,
}
