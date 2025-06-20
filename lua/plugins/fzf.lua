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
        {
            "gd",
            function() require("fzf-lua").lsp_definitions() end,
            desc = "FZF Go To Definition"
        },
        {
            "gD",
            function() require("fzf-lua").lsp_declarations() end,
            desc = "FZF Go To Declaration"
        },
        {
            "gr",
            function() require("fzf-lua").lsp_references() end,
            desc = "FZF References"
        },
        {
            "gri",
            function() require("fzf-lua").lsp_implementations() end,
            desc = "FZF Go To Implementations"
        },
        {
            "grt",
            function() require("fzf-lua").lsp_typedefs() end,
            desc = "FZF Go To Type Definitions"
        },
        {
            "gs",
            function() require("fzf-lua").lsp_document_symbols() end,
            desc = "FZF Document Symbols"
        },
        {
            "gS",
            function() require("fzf-lua").lsp_workspace_symbols() end,
            desc = "FZF Workspace Symbols"
        },
        {
            "<leader>d",
            function() require("fzf-lua").diagnostics_workspace() end,
            desc = "FZF Workspace Diagnostics"
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
