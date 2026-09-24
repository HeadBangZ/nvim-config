local M = {}

M.settings = {
    transparent = true,
    italic_comments = true,
    italic_keywords = true
}

M.default = "vesper"

M.themes = {
    vesper = {
        src = "https://github.com/datsfilipe/vesper.nvim",
        setup = function(s)
            ---@diagnostic disable-next-line: redundant-parameter
            require("vesper").setup({
                transparent = s.transparent,
                italics = {
                    comments = s.italic_comments,
                    keywords = s.italic_keywords,
                },
            })
        end,
    },
    poimandres = {
        src = "https://github.com/olivercederborg/poimandres.nvim",
        setup = function(s)
            ---@diagnostic disable-next-line: redundant-parameter
            require("poimandres").setup({
                disable_background = s.transparent,
                disable_float_background = s.transparent,
                disable_italics = not s.italic_comments,
                bold_vert_split = false,
                dim_nc_background = false,
            })
        end,
    },
    zenbones = {},
    ["modus-vivendi"] = {},
}

local state_file = vim.fn.stdpath("state") .. "/theme"

local function read_saved()
    local f = io.open(state_file, "r")
    if not f then
        return nil
    end

    local name = f:read("*l")
    f:close()
    return name
end

local function save(name)
    local f = io.open(state_file, "w")
    if f then
        f:write(name)
        f:close()
    end
end

local function get_hl(group)
    return vim.api.nvim_get_hl(0, { name = group, link = false })
end

local function get_color(group, attr, fallback)
    local value = get_hl(group)[attr]
    return value and string.format("#%06x", value) or fallback
end

local function clear_bg(groups)
    for _, group in ipairs(groups) do
        local hl = get_hl(group)
        hl.bg, hl.ctermbg = nil, nil
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.api.nvim_set_hl(0, group, hl)
    end
end

local function set_statusline_groups()
    local text = get_color("Normal", "bg", "#101010")
    local function mode(group, source, fallback)
        vim.api.nvim_set_hl(0, group, { fg = text, bg = get_color(source, "fg", fallback), bold = true })
    end

    mode("StModeNormal", "String", "#a6e3a1")
    mode("StModeVisual", "Constant", "#cba6f7")
    mode("StModeCommand", "Function", "#89b4fa")
    mode("StModeTerminal", "Type", "#fab387")
    mode("LineAndCol", "Statement", "#f9e2af")
end

local function remove_unused(keep)
    local srcs = {}
    for name, theme in pairs(M.themes) do
        if theme.src and name ~= keep then
            srcs[theme.src] = true
        end
    end

    local names = {}
    for _, plugin in ipairs(vim.pack.get()) do
        if srcs[plugin.spec.src] and not plugin.active then
            table.insert(names, plugin.spec.name)
        end
    end

    if #names > 0 then
        local ok, err = pcall(vim.pack.del, names)
        if not ok then
            vim.notify("Failed to remove themes: " .. err, vim.log.levels.WARN)
        end
    end
end

function M.apply(name)
    local theme = M.themes[name]
    if not theme then
        vim.notify("Unknown theme: " .. name, vim.log.levels.ERROR)
        return false
    end

    if theme.src then
        vim.pack.add({ theme.src }, { confirm = false })
    end

    if theme.setup then
        local ok, err = pcall(theme.setup, M.settings)
        if not ok then
            vim.notify(("Theme '%s' setup failed: %s"):format(name, err), vim.log.levels.WARN)
        end
    end

    local ok, err = pcall(vim.cmd.colorscheme, name)
    if not ok then
        vim.notify(("Theme '%s' failed to load: %s"):format(name, err), vim.log.levels.ERROR)
        return false
    end

    remove_unused(name)
    return true
end

function M.setup()
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("config_themes", { clear = true }),
        callback = function(ev)
            if M.settings.transparent then
                clear_bg({ "Normal", "NormalFloat", "LineNr", "SignColumn", "EndOfBuffer" })
            end
            set_statusline_groups()
            if M.themes[ev.match] then
                save(ev.match)
            end
        end,
    })

    vim.api.nvim_create_user_command("Theme", function(opts)
        M.apply(opts.args)
    end, {
        nargs = 1,
        complete = function(arg)
            local names = vim.tbl_filter(function(n)
                return vim.startswith(n, arg)
            end, vim.tbl_keys(M.themes))
            table.sort(names)
            return names
        end,
    })

    local name = read_saved() or M.default
    if not M.apply(name) and name ~= M.default and not M.apply(M.default) then
        vim.cmd.colorscheme("default")
    end
end

return M
