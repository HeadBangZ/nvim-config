return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    opts = {
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
            test = { "Identifier", "#FF00FF" },

            -- Your Custom Soft Colors
            soft_red = { "#f38ba8" },
            soft_peach = { "#fab387" },
            soft_green = { "#a6e3a1" },
            soft_blue = { "#89b4fa" },
            soft_purple = { "#cba6f7" },
        },

        keywords = {
            FIX = { icon = " ", color = "soft_red", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
            TODO = { icon = " ", color = "soft_blue" },
            HACK = { icon = " ", color = "soft_peach" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", color = "soft_purple", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "soft_green", alt = { "INFO" } },
            TEST = { icon = "󰂈 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
    }
}
