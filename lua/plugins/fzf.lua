local fzf_module
local ready = false

local function get_fzf()
    if not fzf_module then
        local ok, fzf = pcall(require, "fzf-lua")
        if not ok then
            return nil
        end
        fzf_module = fzf
    end

    if not ready then
        fzf_module.setup({
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

        fzf_module.register_ui_select()
        ready = true
    end

    return fzf_module
end

local function fzf_action(name)
    return function(...)
        local fzf = get_fzf()
        if fzf then
            fzf[name](...)
        end
    end
end

local map = vim.keymap.set

map("n", "<leader>ff", fzf_action("files"), { desc = "Fzf: [F]ind [F]iles" })
map("n", "<leader>fg", fzf_action("live_grep"), { desc = "Fzf: [F]ind [G]rep" })
map("n", "<leader>fb", fzf_action("buffers"), { desc = "Fzf: [F]ind [B]uffers" })
map("n", "<leader>fh", fzf_action("help_tags"), { desc = "Fzf: [F]ind [H]elp [T]ags" })
map("n", "<leader>fo", fzf_action("oldfiles"), { desc = "Fzf: [F]ind [O]ld [F]iles" })
map("n", "<leader>fc", fzf_action("commands"), { desc = "Fzf: [F]ind [C]ommands" })
map("n", "<leader>fk", fzf_action("keymaps"), { desc = "Fzf: [F]ind [K]eymaps" })
map("n", "<leader>fw", fzf_action("grep_cword"), { desc = "Fzf: [F]ind [C]urrent [W]ord" })
map("n", "<leader>fW", fzf_action("grep_cWORD"), { desc = "Fzf: [F]ind [C]urrent [W]ORD" })
map("n", "<leader>fr", fzf_action("resume"), { desc = "Fzf: [F]ind [R]esume" })
map("n", "<leader>hc", fzf_action("command_history"), { desc = "Fzf: [H]istory [C]ommands" })
map("n", "<leader>hs", fzf_action("search_history"), { desc = "Fzf: [H]istory [S]earch" })

vim.keymap.set("n", "<leader>sl", function()
    local fzf = get_fzf()
    if fzf then
        fzf.marks({ marks = "%l" })
    end
end, { desc = "Fzf: [S]earch [L]ocal [M]arks" })
vim.keymap.set("n", "<leader>sg", function()
    local fzf = get_fzf()
    if fzf then
        fzf.marks({ marks = "%u" })
    end
end, { desc = "Fzf: [S]earch [G]lobal [M]arks" })
