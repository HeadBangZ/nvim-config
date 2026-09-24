local ns = vim.api.nvim_create_namespace("mermaid-ascii")
local group = vim.api.nvim_create_augroup("mermaid-ascii", { clear = true })
local exe = "mermaid-ascii"

local enabled = {}
local timers = {}
local generation = {}
local query

local function get_query()
    query = query or vim.treesitter.query.parse("markdown", [[
        (fenced_code_block
          (info_string (language) @lang)
          (code_fence_content) @content) @block
    ]])
    return query
end

local function find_blocks(buf)
    local ok, parser = pcall(vim.treesitter.get_parser, buf, "markdown")
    if not ok or not parser then
        return {}
    end

    local q = get_query()
    local blocks = {}
    for _, match in q:iter_matches(parser:parse()[1]:root(), buf, 0, -1) do
        local nodes = {}
        for id, list in pairs(match) do
            nodes[q.captures[id]] = list[#list]
        end

        if vim.treesitter.get_node_text(nodes.lang, buf) == "mermaid" then
            local _, _, end_row, end_col = nodes.block:range()
            table.insert(blocks, {
                row = end_col == 0 and end_row - 1 or end_row,
                text = vim.treesitter.get_node_text(nodes.content, buf),
            })
        end
    end
    return blocks
end

local function to_virt_lines(result)
    local lines = { { { "" } } }
    if result.code == 0 then
        for _, line in ipairs(vim.split(result.stdout:gsub("%s+$", ""), "\n")) do
            table.insert(lines, { { line, "Special" } })
        end
    else
        local err = vim.split(vim.trim(result.stderr or ""), "\n")[1] or "unknown error"
        err = err:match('msg="(.-)"') or err
        table.insert(lines, { { "mermaid-ascii: " .. err, "DiagnosticError" } })
    end
    return lines
end

local function render(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        return
    end

    generation[buf] = (generation[buf] or 0) + 1
    local gen = generation[buf]
    local blocks = find_blocks(buf)
    if #blocks == 0 then
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
        return
    end

    local results = {}
    local pending = #blocks
    for i, block in ipairs(blocks) do
        vim.system({ exe }, { stdin = block.text, text = true }, function(out)
            results[i] = out
            pending = pending - 1
            if pending > 0 then
                return
            end

            vim.schedule(function()
                -- Drop results from a render that has since been superseded
                if gen ~= generation[buf] or not vim.api.nvim_buf_is_valid(buf) then
                    return
                end
                vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
                for j, b in ipairs(blocks) do
                    pcall(vim.api.nvim_buf_set_extmark, buf, ns, b.row, 0, {
                        virt_lines = to_virt_lines(results[j]),
                    })
                end
            end)
        end)
    end
end

local function schedule_render(buf)
    local timer = timers[buf]
    if not timer then
        timer = assert(vim.uv.new_timer())
        timers[buf] = timer
    end
    timer:stop()
    timer:start(300, 0, vim.schedule_wrap(function()
        render(buf)
    end))
end

local function enable(buf)
    if vim.fn.executable(exe) == 0 then
        vim.notify("mermaid-ascii not found on PATH", vim.log.levels.WARN)
        return
    end
    enabled[buf] = true
    render(buf)
end

local function disable(buf)
    enabled[buf] = nil
    generation[buf] = (generation[buf] or 0) + 1
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
end

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "markdown",
    callback = function(ev)
        if vim.fn.executable(exe) == 1 then
            enable(ev.buf)
        end
    end,
})

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
    group = group,
    callback = function(ev)
        if enabled[ev.buf] then
            schedule_render(ev.buf)
        end
    end,
})

vim.api.nvim_create_autocmd("BufWipeout", {
    group = group,
    callback = function(ev)
        if timers[ev.buf] then
            timers[ev.buf]:close()
        end
        timers[ev.buf], enabled[ev.buf], generation[ev.buf] = nil, nil, nil
    end,
})

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "markdown" and vim.fn.executable(exe) == 1 then
        enable(buf)
    end
end

vim.keymap.set("n", "<leader>rmm", function()
    local buf = vim.api.nvim_get_current_buf()
    if enabled[buf] then
        disable(buf)
    else
        enable(buf)
    end
end, { desc = "Mermaid: [T]oggle ASCII [M]ermaid [D]iagrams" })
