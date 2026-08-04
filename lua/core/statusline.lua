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
    elseif m == "c" then
        hl = "StModeCommand"
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
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'c' or mode == 't' then
        return ' λ '
    end

    local counts = vim.diagnostic.count(0)
    local severity = vim.diagnostic.severity

    if counts[severity.ERROR] and counts[severity.ERROR] > 0 then
        return ' ✘ '
    elseif counts[severity.WARN] and counts[severity.WARN] > 0 then
        return ' ▲ '
    end

    return ' λ '
end

function cmp.marks_status()
    local lmarks = vim.fn.getmarklist(vim.api.nvim_get_current_buf())
    local gmarks = vim.fn.getmarklist()

    local l_count = 0
    local g_count = 0

    for _, m in ipairs(lmarks) do
        if m.mark:match("'[a-z]") then
            l_count = l_count + 1
        end
    end
    for _, m in ipairs(gmarks) do
        if m.mark:match("'[A-Z]") then
            g_count = g_count + 1
        end
    end

    if l_count == 0 and g_count == 0 then
        return ""
    end

    return string.format("󰈚 %d 󰳊 %d", l_count, g_count)
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
    return hi_pattern:format("LineAndCol", "%3l:%-2c")
end

function _G._statusline_component(name)
    return cmp[name]()
end

local statusline = {
    '%{%v:lua._statusline_component("mode")%}',
    '%{%v:lua._statusline_component("git")%}',
    ' %t %m %r',
    ' %{%v:lua._statusline_component("diagnostic_status")%} ',
    '%=',
    '%{%v:lua._statusline_component("marks_status")%} ',
    ' %{%v:lua._statusline_component("fileicon")%}',
    '%{&filetype} ',
    ' [%{%v:lua._statusline_component("encoding")%}] ',
    ' %3p%% ',
    '%{%v:lua._statusline_component("position")%}'
}

vim.opt.statusline = table.concat(statusline, "")
