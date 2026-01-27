local opt = vim.opt

if vim.fn.executable("rg") == 1 then
    local ignores = {
        "!.git/*",
        "!node_modules/*",
        "!vendor/*",
        "!target/*",
        "!bin/*",
        "!obj/*",
        "!build/*",
        "!.cache/*",
    }

    local grep_cmd = "rg --vimgrep --no-heading --smart-case --hidden"
    for _, pattern in ipairs(ignores) do
        grep_cmd = grep_cmd .. ' --glob="' .. pattern .. '"'
    end
    opt.grepprg = grep_cmd
    opt.grepformat = "%f:%l:%c:%m"
end

if vim.fn.has("win32") == 1 then
    opt.shellpipe = ">%s 2>&1"
end

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    group = vim.api.nvim_create_augroup("AutoOpenQuickfix", { clear = true }),
    pattern = { "grep", "make" },
    callback = function()
        vim.cmd("cwindow")
    end,
})

local keymap = vim.keymap.set

keymap("n", "<leader>rg", ":grep! ", { desc = "Grep project..." })

keymap("n", "<leader>q", function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "Toggle Quickfix Window" })
