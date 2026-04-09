vim.cmd("packadd nvim.difftool")

vim.keymap.set("n", "<leader>df", function()
    local target = vim.fn.input("Compare File: ", "", "file")
    if target ~= "" then
        vim.cmd("DiffTool % " .. target)
    end
end, { desc = "[D]iff [F]ile" })

vim.keymap.set("n", "<leader>da", ":DiffTool ", { desc = "[D]iff [A]ny" })
