return {
    'stevearc/oil.nvim',
    opts = {
        default_file_explorer = true,
        columns = { "icon" },
        view_options = {
            show_hidden = true,
        },
        win_options = {
            winbar = "%!v:lua._G.get_oil_winbar()",
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
        function _G.get_oil_winbar()
            local bufnr = vim.api.nvim_get_current_buf()
            local dir = require("oil").get_current_dir(bufnr)

            if dir then
                return vim.fn.fnamemodify(dir, ":~")
            else
                return vim.api.nvim_buf_get_name(bufnr)
            end
        end

        require('oil').setup(opts)
    end
}
