local ok, hl_colors = pcall(require, "nvim-highlight-colors")
if not ok then
    return
end

hl_colors.setup({
    render = "background",
    enable_named_colors = true,
})
