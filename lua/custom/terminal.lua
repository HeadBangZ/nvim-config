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

local function get_float_config()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    return {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
    }
end

-- local function setup_term_options()
--     vim.opt_local.number = false
--     vim.opt_local.relativenumber = false
--     vim.opt_local.signcolumn = "no"
--     vim.cmd("startinsert")
-- end

local function get_shell()
    if vim.fn.has("win32") == 1 then
        if vim.fn.executable("pwsh") == 1 then
            return "pwsh.exe"
        end
        return "powershell.exe"
    end
    return os.getenv("SHELL")
end

local function toggle_float()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    local buf = get_or_create_buf()
    state.win = vim.api.nvim_open_win(buf, true, get_float_config())

    vim.wo[state.win].winhighlight = "FloatBorder:Function"

    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    if vim.bo[buf].buftype ~= "terminal" then
        vim.cmd.term(get_shell())
    end

    vim.cmd("startinsert")
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>st", toggle_float, { desc = "Terminal: Toggle Float" })
vim.keymap.set("t", "<leader>st", function()
    vim.cmd("stopinsert")
    toggle_float()
end, { desc = "Terminal: Toggle Float" })

-- Exit terminal insert mode so standard Vim navigation (Ctrl-U, Ctrl-D, k, j) works for scrolling
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)

return {
    toggle_float = toggle_float,
}

-- local function toggle_split()
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--         if vim.api.nvim_win_get_buf(win) == state.buf then
--             vim.api.nvim_win_close(win, true)
--             return
--         end
--     end
--
--     local buf = get_or_create_buf()
--     vim.cmd("botright 30split")
--     vim.api.nvim_win_set_buf(0, buf)
--
--     if vim.bo[buf].buftype ~= "terminal" then
--         vim.cmd.term(get_shell())
--     end
--     setup_term_options()
-- end
--
-- local opts = { noremap = true, silent = true }
--
-- vim.keymap.set("n", "<leader>st", toggle_split, { desc = "Terminal: Toggle Split" })
-- vim.keymap.set("t", "<leader>st", function()
--     vim.cmd("stopinsert")
--     toggle_split()
-- end, { desc = "Terminal: Toggle Split" })
--
-- vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)
--
-- return {
--     toggle_split = toggle_split
-- }
