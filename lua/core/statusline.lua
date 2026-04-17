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
    return hi_pattern:format("StatusLineMode", " " .. current_mode .. " ")
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

function cmp.position()
    return hi_pattern:format("Search", " %3l:%-2c ")
end

function _G._statusline_component(name)
    return cmp[name]()
end

local statusline = {
    '%{%v:lua._statusline_component("mode")%}',
    ' %t',
    '%r',
    '%m',
    '%=',
    '%{%v:lua._statusline_component("fileicon")%}',
    ' %{&filetype}',
    '%2p%%',
    '%{%v:lua._statusline_component("position")%}'
}

vim.opt.statusline =
[[%{%v:lua._statusline_component("mode")%} %t %r %m %= %{%v:lua._statusline_component("fileicon")%} %{&filetype} %2p%% %{%v:lua._statusline_component("position")%}]]
