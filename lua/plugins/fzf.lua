local ok, fzf = pcall(require, "fzf-lua")
if not ok then return end

fzf.setup({
    fzf_colors = {
        true,
        bg = '-1',
        gutter = '-1'
    },
    winopts = {
        height = 0.7,
        width = 0.7,
        row = 0.5,
        col = 0.5,
        border = "rounded",
        -- preview = {
        --     layout = "vertical",
        --     vertical = "down:50%",
        -- },
    },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-d>"] = "preview-half-page-down",
            ["<C-u>"] = "preview-half-page-up",
            ["<C-e>"] = "preview-down",
            ["<C-y>"] = "preview-up",
        },
    },
    git_icons = true,
    file_icons = true,
    color_icons = true,
})

fzf.register_ui_select()

local map = vim.keymap.set

map("n", "<leader>ff", fzf.files, { desc = "[F]ind [F]iles" })
map("n", "<leader>fg", fzf.live_grep, { desc = "[F]ind [G]rep" })
map("n", "<leader>fb", fzf.buffers, { desc = "[F]ind [B]uffers" })
map("n", "<leader>fh", fzf.help_tags, { desc = "[F]ind [H]elp tags" })
map("n", "<leader>fo", fzf.oldfiles, { desc = "[F]ind [O]ld files" })
map("n", "<leader>fc", fzf.commands, { desc = "[F]ind [C]ommands" })
map("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })
map("n", "<leader>fw", fzf.grep_cword, { desc = "[F]ind current [W]ord" })
map("n", "<leader>fW", fzf.grep_cWORD, { desc = "[F]ind current [W]ORD" })
map("n", "<leader>fr", fzf.resume, { desc = "[F]ind [R]esume" })
map("n", "<leader>hc", fzf.command_history, { desc = "[H]istory [C]ommands" })
map("n", "<leader>hs", fzf.search_history, { desc = "[H]istory [S]earch" })

vim.keymap.set("n", "<leader>sl", function()
    fzf.marks({
        marks = "%l"
    })
end, { desc = "[S]earch [L]ocal [M]arks" })
vim.keymap.set("n", "<leader>sg", function()
    fzf.marks({
        marks = "%u"
    })
end, { desc = "[S]earch [G]lobal [M]arks" })
