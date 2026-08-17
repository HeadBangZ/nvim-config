local pair_map = {
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['"'] = '"',
    ["'"] = "'",
    ['`'] = '`',
    ['´'] = '´',
}

local function is_in_string_or_comment()
    local ok, node = pcall(vim.treesitter.get_node)
    if not ok or not node then return false end
    local type = node:type()
    return type:find("string") ~= nil or type:find("comment") ~= nil
end

for open, close in pairs(pair_map) do
    vim.keymap.set('i', open, function()
        local col = vim.fn.col('.')
        local line = vim.fn.getline('.')
        local char_after = line:sub(col, col)

        if open == close and char_after == close then
            return '<Right>'
        end

        if (open == '"' or open == "'" or open == '`') and is_in_string_or_comment() then
            return open
        end

        if char_after:match('[%w%_]') then
            return open
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

vim.keymap.set('i', '<Space>', function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local char_before = line:sub(col - 1, col - 1)
    local char_after = line:sub(col, col)

    if pair_map[char_before] == char_after and char_before ~= '' then
        return '<Space><Space><Left>'
    end
    return '<Space>'
end, { expr = true })

vim.keymap.set('i', '<BS>', function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local char_before = line:sub(col - 1, col - 1)
    local char_after = line:sub(col, col)

    local char_2before = line:sub(col - 2, col - 2)
    local char_2after = line:sub(col + 1, col + 1)
    if char_before == ' ' and char_after == ' ' and pair_map[char_2before] == char_2after then
        return '<BS><Del>'
    end

    if pair_map[char_before] == char_after and char_before ~= '' then
        return '<BS><Del>'
    end
    return '<BS>'
end, { expr = true })

vim.keymap.set('i', '<CR>', function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local char_before = line:sub(col - 1, col - 1)
    local char_after = line:sub(col, col)

    if pair_map[char_before] == char_after and char_before ~= '' then
        return '<CR><Esc>O'
    end
    return '<CR>'
end, { expr = true })
