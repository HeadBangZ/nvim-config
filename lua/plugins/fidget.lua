return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
        require("fidget").setup({
            notification = {
                window = {
                    normal_hl = "Comment",
                    border = "rounded",
                    x_padding = 1,
                    y_padding = 1,
                    align = "bottom",
                    relative = "editor",
                    winblend = 0
                },
            },
        })
    end,
}
