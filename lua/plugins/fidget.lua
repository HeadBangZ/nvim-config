return {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
        require("fidget").setup({
            notification = {
                window = {
                    normal_hl = "Comment",
                    border = "rounded",
                    x_padding = 1,
                    y_padding = 0,
                    align = "bottom",
                    relative = "editor",
                },
            },
        })
        vim.notify = require("fidget").notify
    end,
}
