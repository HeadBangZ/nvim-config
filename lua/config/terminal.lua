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

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-t>", toggle_term, { desc = "Toggle Terminal" })

vim.keymap.set("t", "<C-t>", function()
    vim.cmd("stopinsert")
    toggle_term()
end, { desc = "Toggle Terminal" })

vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)

return {
    toggle_term = toggle_term
}
