vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        require("plugins.mini_pairs").setup()
        require("plugins.surround").setup()
        require("plugins.blink").setup()
    end,
})
