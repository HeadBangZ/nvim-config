local status, notify = pcall(require, "notify")
if not status then return end

notify.setup({
    level = vim.log.levels.TRACE,
    stages = "fade",
    timeout = 3000,
    background_colour = "#000000",
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎"
    },
    render = "default",
    max_height = function()
        return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
        return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
})

local error_color = "#fe6363"
local warn_color = "#f0dd82"
local info_color = "#a6e3a1"
local debug_color = "#89b4fa"

vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = error_color })
vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = error_color })
vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = error_color })

vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = warn_color })
vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = warn_color })
vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = warn_color })

vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = info_color })
vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = info_color })
vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = info_color })

vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = debug_color })
vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = debug_color })
vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = debug_color })

vim.notify = notify
