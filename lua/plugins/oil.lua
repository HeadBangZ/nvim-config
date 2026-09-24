local ok, oil = pcall(require, "oil")
if not ok then return end

function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = oil.get_current_dir(bufnr)

    if dir then
        local path = dir and vim.fn.fnamemodify(dir, ":~") or vim.api.nvim_buf_get_name(bufnr)
        return (path:gsub("%%", "%%%%"))
    else
        return vim.api.nvim_buf_get_name(bufnr)
    end
end

oil.setup({
    default_file_explorer = true,
    columns = { "icon" },
    view_options = {
        show_hidden = true,
    },
    win_options = {
        winbar = "%!v:lua._G.get_oil_winbar()",
    },
})
