vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        local ok, surround = pcall(require, "nvim-surround")
        if not ok then
            return
        end

        surround.setup({})
    end
})
