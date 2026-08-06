local pair_map = {
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['"'] = '"',
    ["'"] = "'",
    ['`'] = '`',
    ['´'] = '´',
    ['<'] = '>',
}

for open, close in pairs(pair_map) do
    vim.keymap.set('i', open, function()
        local col = vim.fn.col('.')
        local line = vim.fn.getline('.')
        local char_after = line:sub(col, col)

        if open == close and char_after == close then
            return '<Right>'
        end
        return open .. close .. '<Left>'
    end, { expr = true })

    if open ~= close then
        vim.keymap.set('i', close, function()
            local col = vim.fn.col('.')
            local line = vim.fn.getline('.')
            local char_after = line:sub(col, col)

            if char_after == close then
                return '<Right>'
            end
            return close
        end, { expr = true })
    end
end

vim.keymap.set('i', '<BS>', function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local char_before = line:sub(col - 1, col - 1)
    local char_after = line:sub(col, col)

    if pair_map[char_before] == char_after and char_before ~= '' then
        return '<BS><Del>'
    end
    return '<BS>'
end, { expr = true })
