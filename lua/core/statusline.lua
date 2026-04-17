local cmp = {}

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

    local hl_map = {
        n = "StatusLineNormal",
        i = "StatusLineInsert",
        v = "StatusLineVisual",
        V = "StatusLineVisual",
        ["\22"] = "StatusLineVisual",
        c = "StatusLineCommand",
        t = "StatusLineTerminal"
    }
    local current_mode = modes[m] or 'NORMAL'
    local hl = hl_map[m] or "StatusLineNormal"
    return string.format("%%#%s# %s %%*", hl, current_mode)
end

function _G.statusline_render()
    return table.concat({ cmp.mode(), " %t ", "%=", " %l:%c " })
end

vim.opt.statusline = "%!v:lua.statusline_render()"
