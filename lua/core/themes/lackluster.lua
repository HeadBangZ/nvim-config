local M = {}

function M.setup()
    local lackluster = require("lackluster")
    lackluster.setup({
        tweak_background = {
            normal = "none",
        },
        tweak_highlight = {
            ["MsgArea"] = {
                overwrite = true,
                fg = lackluster.color.luster,
            },
            ["@comment"] = {
                overwrite = true,
                fg = lackluster.color.gray5,
                italic = true,
            },
        },
    })
end

return M
