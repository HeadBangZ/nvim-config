local ok, todo = pcall(require, "todo-comments")
if not ok then
    return
end

todo.setup({
    colors = {
        -- Your Custom Soft Colors
        soft_error = { "#f38ba8" },
        soft_warning = { "#f9e2af" },
        soft_hack = { "#fab387" },
        soft_info = { "#89b4fa" },
        soft_note = { "#a6e3a1" },
        soft_perf = { "#cba6f7" },
        soft_test = { "#f5c2e7" },
    },

    keywords = {
        FIX = { icon = " ", color = "soft_error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "soft_info" },
        HACK = { icon = " ", color = "soft_hack" },
        WARN = { icon = " ", color = "soft_warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰓅 ", color = "soft_perf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "soft_note", alt = { "INFO" } },
        TEST = { icon = "󰙨 ", color = "soft_test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
})

vim.keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "[F]ind [T]odos" })

