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
        border = "single",
        preview = {
            layout = "horizontal",
            vertical = "down:70%",
        },
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

map("n", "<leader>ff", fzf.files, { desc = "Fzf: [F]ind [F]iles" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Fzf: [F]ind [G]rep" })
map("n", "<leader>fb", fzf.buffers, { desc = "Fzf: [F]ind [B]uffers" })
map("n", "<leader>fh", fzf.help_tags, { desc = "Fzf: [F]ind [H]elp [T]ags" })
map("n", "<leader>fo", fzf.oldfiles, { desc = "Fzf: [F]ind [O]ld [F]iles" })
map("n", "<leader>fc", fzf.commands, { desc = "Fzf: [F]ind [C]ommands" })
map("n", "<leader>fk", fzf.keymaps, { desc = "Fzf: [F]ind [K]eymaps" })
map("n", "<leader>fw", fzf.grep_cword, { desc = "Fzf: [F]ind [C]urrent [W]ord" })
map("n", "<leader>fW", fzf.grep_cWORD, { desc = "Fzf: [F]ind [C]urrent [W]ORD" })
map("n", "<leader>fr", fzf.resume, { desc = "Fzf: [F]ind [R]esume" })
map("n", "<leader>hc", fzf.command_history, { desc = "Fzf: [H]istory [C]ommands" })
map("n", "<leader>hs", fzf.search_history, { desc = "Fzf: [H]istory [S]earch" })

vim.keymap.set("n", "<leader>sl", function()
    fzf.marks({
        marks = "%l"
    })
end, { desc = "Fzf: [S]earch [L]ocal [M]arks" })
vim.keymap.set("n", "<leader>sg", function()
    fzf.marks({
        marks = "%u"
    })
end, { desc = "Fzf: [S]earch [G]lobal [M]arks" })
