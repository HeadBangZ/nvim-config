return {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        local peek = require("peek")
        peek.setup({
            app = 'webview',
            theme = 'dark',
        })

        vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
        vim.api.nvim_create_user_command('PeekClose', peek.close, {})

        vim.keymap.set('n', '<leader>p', function()
            if peek.is_open() then
                peek.close()
            else
                peek.open()
            end
        end, { desc = "Toggle Markdown Preview" })
    end,
}
