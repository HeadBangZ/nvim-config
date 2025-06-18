return {
    "ibhagwan/fzf-lua",
    opts = {},
    keys = {
        {
            "<leader>ff",
            function() require("fzf-lua").files() end,
            desc = "FZF Find Files Current Working Directory"
        },
        {
            "<leader>fg",
            function() require("fzf-lua").live_grep() end,
            desc = "FZF Live Grep"
        },
        {
            "<leader>fb",
            function() require("fzf-lua").buffers() end,
            desc = "FZF Buffers"
        },
        {
            "<leader>fh",
            function() require("fzf-lua").help_tags() end,
            desc = "FZF Help Tags"
        },
        {
            "<leader>fo",
            function() require("fzf-lua").oldfiles() end,
            desc = "FZF Old Files"
        },
        {
            "<leader>fc",
            function() require("fzf-lua").commands() end,
            desc = "FZF Commands"
        },
        {
            "<leader>fk",
            function() require("fzf-lua").keymaps() end,
            desc = "FZF Keymaps"
        },
        {
            "<leader>fw",
            function() require("fzf-lua").grep_cword() end,
            desc = "FZF Grep Word Under Cursor"
        },
        {
            "<leader>fr",
            function() require("fzf-lua").resume() end,
            desc = "FZF Resume"
        },
    },
    config = function()
        require("fzf-lua").setup({
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
    end
}
