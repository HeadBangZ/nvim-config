-- Plugin specific configurations
require("plugins.themes")
require("plugins.arrow")
require("plugins.autopairs")
require("plugins.oil")
require("plugins.lualine")

vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        require("plugins.autopairs")
    end,
    once = true,
})
