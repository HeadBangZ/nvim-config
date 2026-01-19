return {
    "ibhagwan/fzf-lua",
    opts = {},
    keys = {
        {
            "<leader>ff",
            function() require("fzf-lua").files() end,
            desc = "[F]ind [F]iles"
        },
        {
            "<leader>fg",
            function() require("fzf-lua").live_grep() end,
            desc = "[F]ind [G]rep"
        },
        {
            "<leader>fb",
            function() require("fzf-lua").buffers() end,
            desc = "[F]ind [B]uffers"
        },
        {
            "<leader>fh",
            function() require("fzf-lua").help_tags() end,
            desc = "[F]ind [H]elp tags"
        },
        {
            "<leader>fo",
            function() require("fzf-lua").oldfiles() end,
            desc = "[F]ind [O]ld files"
        },
        {
            "<leader>fc",
            function() require("fzf-lua").commands() end,
            desc = "[F]ind [C]ommands"
        },
        {
            "<leader>fk",
            function() require("fzf-lua").keymaps() end,
            desc = "[F]ind [K]eymaps"
        },
        {
            "<leader>fw",
            function() require("fzf-lua").grep_cword() end,
            desc = "[F]ind current [W]ord"
        },
        {
            "<leader>fW",
            function() require("fzf-lua").grep_cWORD() end,
            desc = "[F]ind current [W]ORD"
        },
        {
            "<leader>fr",
            function() require("fzf-lua").resume() end,
            desc = "[F]ind [R]esume"
        },
        {
            "<leader>hc",
            function() require("fzf-lua").command_history() end,
            desc = "[H]istory [C]ommands"
        },
        {
            "<leader>hs",
            function() require("fzf-lua").search_history() end,
            desc = "[H]istory [S]earch"
        }
    },
    config = function()
        local fzf = require("fzf-lua")
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
            },
            git_icons = true,
            file_icons = true,
            color_icons = true,
        })

        fzf.register_ui_select()
    end
}
