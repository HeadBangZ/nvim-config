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

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP: [F]ormat document", silent = true })

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "<leader>v", "<C-w>v", opts)
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts)

vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)
