vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>cd", vim.cmd.Oil, { desc = "Open Oil file explorer" })
vim.keymap.set("n", "<leader>E", function()
        require("oil").open_float(vim.loop.cwd())
    end,
    { desc = "Open Oil file explorer (floating window)" })

vim.keymap.set("n", "<leader>t", "~", { desc = "Toggle Case" })
-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: [R]ename" })

vim.keymap.set("n", "<leader>i",
    function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
    end,
    { desc = "Inlay hints" }
)

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP: [F]ormat [D]ocument", silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove highlights", silent = true })

local opts = { noremap = true, silent = true }

-- scroll up and down and center when searching
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
-- vim.keymap.set("n", "x", '"_x', opts)

-- open window vertically and horizontally
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts)

-- resize window using arrow keys
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- toggle vim-fugitive
vim.keymap.set("n", "<C-M-S-F8>", function()
    for _, win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "fugitive" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
    vim.cmd("Git")
end, { desc = "Toggle Fugitive Window" })

-- jump over closing pairs ) ] } ' "
vim.keymap.set("i", "<C-M-S-F8>", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local next_char = line:sub(col + 2, col + 2)

    if string.find(next_char, "[%)%]%}\"\'%>]") then
        return "<Right>"
    else
        return "<End>"
    end
end, { expr = true, desc = "Jump over closing pairs" })
