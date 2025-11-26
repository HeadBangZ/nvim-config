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

-- scroll up and down and center when searching
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "x", '"_x', opts)

-- open window vertically and horizontally
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts)

-- resize window using arrow keys
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Terminal
local state = {
    win = nil,
    buf = nil,
}

local function toggle_term()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    vim.cmd("botright 12split")
    state.win = vim.api.nvim_get_current_win()
    if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
        vim.api.nvim_win_set_buf(state.win, state.buf)
    else
        local shell_cmd = vim.fn.has("win32") == 1 and "powershell.exe" or ""

        vim.cmd("term " .. shell_cmd)
        state.buf = vim.api.nvim_get_current_buf()

        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end

    vim.cmd("startinsert")
end

vim.keymap.set("n", "<C-t>", toggle_term, { desc = "Toggle Terminal" })
vim.keymap.set("t", "<C-t>", function()
    vim.cmd("stopinsert")
    toggle_term()
end, { desc = "Toggle Terminal" })

vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)
