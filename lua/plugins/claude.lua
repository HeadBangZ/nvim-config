local claudecode = require("claudecode")

claudecode.setup({})

local map = vim.keymap.set

map("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Claude: [T]oggle" })
map("t", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Claude: [T]oggle" })
map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Claude: [F]ocus" })
map("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Claude: [R]esume" })
map("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Claude: [C]ontinue" })
map("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Claude: [S]elect [M]odel" })
map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Claude: [A]dd [B]uffer" })
map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Claude: [S]end [S]election" })
map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Claude: [A]ccept [D]iff" })
map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Claude: [D]eny [D]iff" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function(ev)
        map("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = ev.buf, desc = "Claude: [A]dd [F]ile" })
    end,
})
