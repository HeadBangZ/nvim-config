local loaded = false

local function ensure_loaded()
    if loaded then
        return true
    end

    local ok, diffview = pcall(require, "diffview")
    if not ok then
        return false
    end

    diffview.setup({})
    loaded = true

    return true
end

local map = vim.keymap.set

map("n", "<leader>gd", function()
    if ensure_loaded() then
        vim.cmd("DiffviewOpen")
    end
end, { desc = "Git: [D]iffview [O]pen" })

map("n", "<leader>gh", function()
    if ensure_loaded() then
        vim.cmd("DiffviewFileHistory %")
    end
end, { desc = "Git: [F]ile [H]istory" })

map("n", "<leader>gq", function()
    if ensure_loaded() then
        vim.cmd("DiffviewClose")
    end
end, { desc = "Git: [D]iffview [Q]uit" })
