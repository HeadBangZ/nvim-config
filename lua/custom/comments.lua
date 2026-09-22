local colors = {
    TodoFix  = '#f38ba8',
    TodoWarn = '#f9e2af',
    TodoHack = '#fab387',
    TodoInfo = '#89b4fa',
    TodoNote = '#a6e3a1',
    TodoPerf = '#cba6f7',
    TodoTest = '#f5c2e7',
}

local keyword_groups = {
    TodoFix  = '\\v<(FIX|FIXME|BUG|FIXIT|ISSUE):',
    TodoInfo = '\\v<(TODO):',
    TodoHack = '\\v<(HACK):',
    TodoWarn = '\\v<(WARN|WARNING|XXX):',
    TodoPerf = '\\v<(PERF|OPTIM|PERFORMANCE|OPTIMIZE):',
    TodoNote = '\\v<(NOTE|INFO):',
    TodoTest = '\\v<(TEST|TESTING|PASSED|FAILED):',
}

local group = vim.api.nvim_create_augroup("todo-comments", { clear = true })

local function apply_highlights()
    for name, color in pairs(colors) do
        vim.api.nvim_set_hl(0, name, { fg = "#11111b", bg = color, bold = true })
    end
end

vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = apply_highlights })
apply_highlights()

local function apply_matches()
    for _, id in ipairs(vim.w.todo_match_ids or {}) do
        pcall(vim.fn.matchdelete, id)
    end

    if vim.bo.buftype ~= "" then
        vim.w.todo_match_ids = {}
        return
    end

    local ids = {}
    for name, pattern in pairs(keyword_groups) do
        local ok, id = pcall(vim.fn.matchadd, name, pattern)
        if ok then
            table.insert(ids, id)
        end
    end
    vim.w.todo_match_ids = ids
end

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinNew' }, {
    group = group,
    callback = apply_matches,
})

vim.keymap.set('n', '<leader>ft', function()
    require('fzf-lua').grep({
        search =
        [[\b(FIX|FIXME|BUG|FIXIT|ISSUE|TODO|HACK|WARN|WARNING|PERF|OPTIM|PERFORMANCE|OPTIMIZE|NOTE|INFO|TEST|TESTING|PASSED|FAILED):]],
        no_esc = true,
    })
end, { desc = 'Fzf: [F]ind [T]ags (TODO/FIX/NOTE)' })
