local status_lualine, lualine = pcall(require, "lualine")
if not status_lualine then
    return
end

local function marks_status()
    local local_marks = vim.fn.getmarklist(vim.api.nvim_get_current_buf())
    local global_marks = vim.fn.getmarklist()

    local l_count = 0
    local g_count = 0

    for _, m in ipairs(local_marks) do
        if m.mark:match("'[a-z]") then
            l_count = l_count + 1
        end
    end

    for _, m in ipairs(global_marks) do
        if m.mark:match("'[A-Z]") then
            g_count = g_count + 1
        end
    end

    if l_count == 0 and g_count == 0 then
        return ""
    end

    return string.format("󰈚 %d 󰳊 %d", l_count, g_count)
end

lualine.setup({
    options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
            "filename",
            { marks_status, color = { fg = "#ffc799" } }
        },
        lualine_x = { "diagnostics", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
