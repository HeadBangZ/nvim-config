local ok, wk = pcall(require, "which-key")
if not ok then
    return
end

wk.setup({
    icons = {
        rules = false,
        font = "nvim-web-devicons"
    }
})

vim.keymap.set("n", "<leader>?", function()
    wk.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
