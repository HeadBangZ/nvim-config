vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        local ok, autopairs = pcall(require, "nvim-autopairs")
        if not ok then
            return
        end

        autopairs.setup({
            check_ts = true,
            enable_check_bracket_line = true
        })
    end,
})
