local M = {}

function M.setup()
    require("vesper").setup({
        transparent = true,
        italics = {
            comments = true,
            keywords = true,
        },
    })
end

return M
