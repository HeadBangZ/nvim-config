local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
    return
end

autopairs.setup({})

vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        require("plugins.autopairs")
    end,
    once = true,
})
