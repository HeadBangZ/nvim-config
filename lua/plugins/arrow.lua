return {
    "otavioschwanck/arrow.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        { "ibhagwan/fzf-lua" },
    },
    config = function(_, opts)
        require("arrow").setup(opts)
    end,
    opts = {
        show_icons = true,
        leader_key = "<leader>a",
        buffer_leader_key = "<leader>m",
        window = {
            border = "rounded",
            row = "auto",
            col = "auto",
        }
    },
}
