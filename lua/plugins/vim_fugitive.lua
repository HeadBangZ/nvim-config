local function toggle_fugitive()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "fugitive" then
            vim.api.nvim_win_close(win, false)
            return
        end
    end
    vim.cmd.Git()
end

local map = vim.keymap.set

map("n", "<leader>gs", vim.cmd.Git, { desc = "Git: [S]tatus" })
map("n", "<C-M-S-F8>", toggle_fugitive, { desc = "Git: [T]oggle [F]ugitive [W]indow" })
