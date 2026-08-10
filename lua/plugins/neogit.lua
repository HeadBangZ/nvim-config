local ok, neogit = pcall(require, "neogit")
if not ok then
    return
end

neogit.setup({
    dependencies = {
        "sindrets/diffview.nvim",
        "ibhagwan/fzf-lua",
    },
    opts = {
        integrations = {
            diffview = true,
            fzf_lua = true,
        },
        kind = "floating",
    },
})
