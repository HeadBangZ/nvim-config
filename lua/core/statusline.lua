local cmp = {}
local hi_pattern = '%%#%s# %s %%*'

function cmp.mode()
    local modes = {
        ['n'] = 'NORMAL',
        ['no'] = 'OP-PENDING',
        ['nov'] = 'OP-PENDING',
        ['noV'] = 'OP-PENDING',
        ['no\22'] = 'OP-PENDING',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['ntT'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL',
        ['Vs'] = 'VISUAL',
        ['\22'] = 'VISUAL',
        ['\22s'] = 'VISUAL',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT',
        ['\19'] = 'SELECT',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rv'] = 'VIRT REPLACE',
        ['Rvc'] = 'VIRT REPLACE',
        ['Rvx'] = 'VIRT REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }
    local m = vim.api.nvim_get_mode().mode

    local current_mode = modes[m] or 'NORMAL'

    local hl = "StModeNormal"
    if m == "i" or m == "ic" or m == "ix" then
        hl = "StModeInsert"
    elseif m:find("v") or m:find("V") or m == "\22" then
        hl = "StModeVisual"
    elseif m == "t" then
        hl = "StModeTerminal"
    end

    return hi_pattern:format(hl, current_mode)
end

function cmp.git()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or not git_info.head then
        return ""
    end

    local parts = { " " .. git_info.head }

    if git_info.added and git_info.added > 0 then
        table.insert(parts, " +" .. git_info.added)
    end
    if git_info.changed and git_info.changed > 0 then
        table.insert(parts, " ~" .. git_info.changed)
    end
    if git_info.removed and git_info.removed > 0 then
        table.insert(parts, " -" .. git_info.removed)
    end

    local status = table.concat(parts, "")
    return hi_pattern:format("StatusLineGit", " " .. status .. " ")
end

function cmp.diagnostic_status()
    local ok = ' λ '

    local ignore = {
        ['c'] = true, -- command mode
        ['t'] = true  -- terminal mode
    }

    local mode = vim.api.nvim_get_mode().mode

    if ignore[mode] then
        return ok
    end

    local levels = vim.diagnostic.severity
    local errors = #vim.diagnostic.get(0, { severity = levels.ERROR })
    if errors > 0 then
        return ' ✘ '
    end

    local warnings = #vim.diagnostic.get(0, { severity = levels.WARN })
    if warnings > 0 then
        return ' ▲ '
    end

    return ok
end

function cmp.fileicon()
    local ok, icons = pcall(require, "nvim-web-devicons")
    if not ok then
        return ""
    end

    local name = vim.fn.expand("%:t")
    local ext = vim.fn.expand("%:e")
    local icon, hl = icons.get_icon(name, ext, { defualt = true })

    return string.format(" %%#%s#%s%%* ", hl or "StatusLine", icon or "")
end

function cmp.encoding()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    return string.upper(enc)
end

function cmp.position()
    return hi_pattern:format("Search", "%3l:%-2c")
end

function _G._statusline_component(name)
    return cmp[name]()
end

local statusline = {
    '%{%v:lua._statusline_component("mode")%}',
    '%{%v:lua._statusline_component("git")%}',
    '%{%v:lua._statusline_component("diagnostic_status")%} ',
    ' %t %m %r',
    '%=',
    -- global and local marks
    ' %{%v:lua._statusline_component("fileicon")%}',
    ' %{&filetype} ',
    '[%{%v:lua._statusline_component("encoding")%}] ',
    ' %2p%% ',
    '%{%v:lua._statusline_component("position")%}'
}

vim.opt.statusline = table.concat(statusline, "")
