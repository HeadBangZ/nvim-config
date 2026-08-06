local colors = {
    TodoFix  = '#f38ba8',
    TodoWarn = '#f9e2af',
    TodoHack = '#fab387',
    TodoInfo = '#89b4fa',
    TodoNote = '#a6e3a1',
    TodoPerf = '#cba6f7',
    TodoTest = '#f5c2e7',
}

for group, color in pairs(colors) do
    vim.api.nvim_set_hl(0, group, { fg = "#11111b", bg = color, bold = true })
end

local keyword_groups = {
    TodoFix  = '\\v<(FIX|FIXME|BUG|FIXIT|ISSUE):',
    TodoInfo = '\\v<(TODO):',
    TodoHack = '\\v<(HACK):',
    TodoWarn = '\\v<(WARN|WARNING|XXX):',
    TodoPerf = '\\v<(PERF|OPTIM|PERFORMANCE|OPTIMIZE):',
    TodoNote = '\\v<(NOTE|INFO):',
    TodoTest = '\\v<(TEST|TESTING|PASSED|FAILED):',
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
    callback = function()
        pcall(vim.fn.clearmatches)
        for group, pattern in pairs(keyword_groups) do
            vim.fn.matchadd(group, pattern)
        end
    end,
})

vim.keymap.set('n', '<leader>ft', function()
    require('fzf-lua').grep({
        search =
        [[\b(FIX|FIXME|BUG|FIXIT|ISSUE|TODO|HACK|WARN|WARNING|PERF|OPTIM|PERFORMANCE|OPTIMIZE|NOTE|INFO|TEST|TESTING|PASSED|FAILED):]],
        no_esc = true,
    })
end, { desc = '[F]ind [T]ags (TODO/FIX/NOTE)' })
