local state = {
    win = nil,
    buf = nil,
}

local function get_float_config()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    return {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "single"
    }
end

local function get_shell()
    if vim.fn.executable("pwsh") == 1 then
        return "pwsh.exe"
    end
    return "powershell.exe"
end

local function toggle_float()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
        state.buf = vim.api.nvim_create_buf(false, true)
    end

    state.win = vim.api.nvim_open_win(state.buf, true, get_float_config())

    vim.api.nvim_create_autocmd("TermClose", {
        buffer = state.buf,
        once = true,
        callback = function()
            if state.win and vim.api.nvim_win_is_valid(state.win) then
                vim.api.nvim_win_close(state.win, true)
                state.win = nil
            end
            state.buf = nil
        end,
    })

    vim.api.nvim_create_autocmd("VimResized", {
        buffer = state.buf,
        callback = function()
            if state.win and vim.api.nvim_win_is_valid(state.win) then
                vim.api.nvim_win_set_config(state.win, get_float_config())
            end
        end,
    })

    vim.wo[state.win].winhighlight = "FloatBorder:Function"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    if vim.bo[state.buf].buftype ~= "terminal" then
        vim.cmd.term(get_shell())
    end

    vim.cmd("startinsert")
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<M-b>", toggle_float, { desc = "Terminal: [T]oggle [F]loat" })
vim.keymap.set("t", "<M-b>", function()
    vim.cmd("stopinsert")
    toggle_float()
end, { desc = "Terminal: [T]oggle [F]loat" })

vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)

return {
    toggle_float = toggle_float,
}
