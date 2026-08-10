-- Neogit
vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "[G]it [S]tatus" })
vim.keymap.set("n", "<C-M-S-F8>", function()
    for _, win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "NeogitStatus" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end
    require("neogit").open()
end, { desc = "[T]oggle [N]eogit [W]indow" })

-- Fugitive
-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
-- vim.keymap.set("n", "<C-M-S-F8>", function()
--     for _, win in pairs(vim.api.nvim_list_wins()) do
--         local buf = vim.api.nvim_win_get_buf(win)
--         if vim.bo[buf].filetype == "fugitive" then
--             vim.api.nvim_win_close(win, true)
--             return
--         end
--     end
--     vim.cmd("Git")
-- end, { desc = "Toggle Fugitive Window" })


-- Diffview
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git: [D]iffview [O]pen" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git: [F]ile [H]istory" })
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Git: [D]iffview [Q]uit" })

-- Gitsigns
vim.keymap.set("n", "]h", function() require("gitsigns").nav_hunk("next") end, { desc = "[N]ext [H]unk" })
vim.keymap.set("n", "[h", function() require("gitsigns").nav_hunk("prev") end, { desc = "[P]rev [H]unk" })
vim.keymap.set("n", "<leader>gp", function() require("gitsigns").preview_hunk() end,
    { desc = "Git: [P]review [H]unk" })
vim.keymap.set("n", "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end,
    { desc = "Git: [B]lame [L]ine" })
