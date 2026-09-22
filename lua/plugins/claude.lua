local loaded = false

local function ensure_loaded()
    if loaded then
        return true
    end

    local ok, claudecode = pcall(require, "claudecode")
    if not ok then
        return false
    end

    claudecode.setup({})
    loaded = true

    return true
end

local function cmd(command)
    return function()
        if ensure_loaded() then
            vim.cmd(command)
        end
    end
end

local map = vim.keymap.set

map("n", "<leader>ac", cmd("ClaudeCode"), { desc = "Claude: [T]oggle" })
map("t", "<leader>ac", cmd("ClaudeCode"), { desc = "Claude: [T]oggle" })
map("n", "<leader>af", cmd("ClaudeCodeFocus"), { desc = "Claude: [F]ocus" })
map("n", "<leader>ar", cmd("ClaudeCode --resume"), { desc = "Claude: [R]esume" })
map("n", "<leader>aC", cmd("ClaudeCode --continue"), { desc = "Claude: [C]ontinue" })
map("n", "<leader>am", cmd("ClaudeCodeSelectModel"), { desc = "Claude: [S]elect [M]odel" })
map("n", "<leader>ab", cmd("ClaudeCodeAdd %"), { desc = "Claude: [A]dd [B]uffer" })
map("v", "<leader>as", cmd("ClaudeCodeSend"), { desc = "Claude: [S]end [S]election" })
map("n", "<leader>aa", cmd("ClaudeCodeDiffAccept"), { desc = "Claude: [A]ccept [D]iff" })
map("n", "<leader>ad", cmd("ClaudeCodeDiffDeny"), { desc = "Claude: [D]eny [D]iff" })

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("claudecode-oil", { clear = true }),
    pattern = "oil",
    callback = function(ev)
        map("n", "<leader>as", cmd("ClaudeCodeTreeAdd"), { buffer = ev.buf, desc = "Claude: [A]dd [F]ile" })
    end,
})
