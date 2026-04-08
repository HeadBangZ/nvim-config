local status, arrow = pcall(require, "arrow")
if not status then
    return
end

arrow.setup({
    show_icons = true,
    leader_key = "<leader>a",
    buffer_leader_key = "<leader>m",
    window = {
        border = "rounded",
        row = "auto",
        col = "auto",
    }
})
