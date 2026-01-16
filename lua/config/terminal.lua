local state = {
    win = nil,
    buf = nil,
}

local function get_or_create_buf()
    if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
        state.buf = vim.api.nvim_create_buf(false, true)
    end
    return state.buf
end

local function setup_term_options()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
end

local function get_shell()
    if vim.fn.has("win32") == 1 then
        if vim.fn.executable("pwsh") == 1 then
            return "pwsh.exe"
        end
        return "powershell.exe"
    end
    return os.getenv("SHELL")
end

local function toggle_split()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == state.buf then
            vim.api.nvim_win_close(win, true)
            return
        end
    end

    local buf = get_or_create_buf()
    vim.cmd("botright 12split")
    vim.api.nvim_win_set_buf(0, buf)

    if vim.bo[buf].buftype ~= "terminal" then
        vim.cmd.term(get_shell())
    end
    setup_term_options()
end

-- KEYMAPS
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>st", toggle_split, { desc = "Terminal: Toggle Split" })
vim.keymap.set("t", "<leader>st", function()
    vim.cmd("stopinsert")
    toggle_split()
end, { desc = "Terminal: Toggle Split" })

vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)

return {
    toggle_float = toggle_float,
    toggle_split = toggle_split
}
