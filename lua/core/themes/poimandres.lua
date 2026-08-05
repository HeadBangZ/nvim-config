local M = {}

function M.setup()
    require("poimandres").setup({
        disable_background = true,
        disable_float_background = true,
        bold_vert_split = false,
        dim_nc_background = false,
        disable_italics = false,
    })
end

return M
