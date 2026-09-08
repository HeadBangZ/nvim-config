local ok, neogit = pcall(require, "neogit")
if not ok then
    return
end

neogit.setup({
    integrations = {
        diffview = true,
        fzf_lua = true,
    },
})

local function toggle_neogit()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "NeogitStatus" then
            vim.api.nvim_win_close(win, false)
            return
        end
    end
    neogit.open()
end

local map = vim.keymap.set

map("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Git: [S]tatus" })
map("n", "<C-M-S-F8>", toggle_neogit, { desc = "Git: [T]oggle Neogit Window" })
