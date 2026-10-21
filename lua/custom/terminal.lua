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
    local store = vim.fn.glob(
        [[C:\Program Files\WindowsApps\Microsoft.PowerShell_*_x64__8wekyb3d8bbwe\pwsh.exe]], false, true)
    if #store > 0 then
        return store[#store]
    end
    return "powershell.exe"
end

local function close_float()
    local buf = state.buf
    state.win = nil
    state.buf = nil
    if buf and vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
    end
end

local function toggle_float()
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
        return
    end

    local is_new = not (state.buf and vim.api.nvim_buf_is_valid(state.buf))
    if is_new then
        state.buf = vim.api.nvim_create_buf(false, true)
    end

    state.win = vim.api.nvim_open_win(state.buf, true, get_float_config())

    vim.wo[state.win].winhighlight = "FloatBorder:Function"
    vim.wo[state.win].number = false
    vim.wo[state.win].relativenumber = false
    vim.wo[state.win].signcolumn = "no"

    if is_new then
        vim.fn.jobstart({ get_shell(), "-NoLogo" }, { term = true })
        local buf = state.buf

        vim.api.nvim_create_autocmd("TermClose", {
            buffer = buf,
            once = true,
            callback = function()
                if state.win and vim.api.nvim_win_is_valid(state.win) then
                    vim.api.nvim_win_close(state.win, true)
                    state.win = nil
                end
                state.buf = nil
                vim.schedule(function()
                    if vim.api.nvim_buf_is_valid(buf) then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end)
            end,
        })

        vim.keymap.set({ "n", "t" }, "<M-q>", close_float, { buffer = buf, desc = "Terminal: [Q]uit" })
    end

    vim.cmd("startinsert")
end

vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        if state.win and vim.api.nvim_win_is_valid(state.win) then
            vim.api.nvim_win_set_config(state.win, get_float_config())
        end
    end,
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<M-b>", toggle_float, { desc = "Terminal: [T]oggle [F]loat" })
vim.keymap.set("t", "<M-b>", function()
    vim.cmd("stopinsert")
    toggle_float()
end, { desc = "Terminal: [T]oggle [F]loat" })

vim.keymap.set("t", "<M-n>", [[<C-\><C-n>]], opts)

return {
    toggle_float = toggle_float,
    close_float = close_float,
}
