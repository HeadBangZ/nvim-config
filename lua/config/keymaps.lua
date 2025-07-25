vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>cd", vim.cmd.Oil, { desc = "Open Oil file explorer" })
vim.keymap.set("n", "<leader>E", function()
        require("oil").open_float(vim.loop.cwd())
    end,
    { desc = "Open Oil file explorer (floating window)" })

vim.keymap.set("n", "<leader>t", "~", { desc = "Toggle Case" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: [R]ename" })

vim.keymap.set("n", "<leader>i",
    function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
    end,
    { desc = "Inlay hints" }
)

vim.keymap.set("n", "<leader>h", ":horizontal terminal<CR>", {
    noremap = true,
    silent = true
})
