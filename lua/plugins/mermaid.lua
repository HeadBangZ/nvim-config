local group = vim.api.nvim_create_augroup("mermaid", { clear = true })

local mmdc = vim.fn.has("win32") == 1 and "mmdc.cmd" or "mmdc"

require("mermaid").setup({
    lint = { enabled = vim.fn.executable(mmdc) == 1, command = mmdc },
    preview = { theme = "dark" },
})

local function set_keymaps(buf)
    local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
    end

    map("<leader>mp", "<cmd>MermaidPreview<CR>", "Mermaid: [P]review")
    map("<leader>mx", "<cmd>MermaidPreviewStop<CR>", "Mermaid: [S]top [P]review")
    map("<leader>mf", "<cmd>MermaidFormat<CR>", "Mermaid: [F]ormat")
    map("<leader>mc", "<cmd>MermaidCopyURL<CR>", "Mermaid: [C]opy [P]review [U]RL")
end

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "mermaid",
    callback = function(ev)
        set_keymaps(ev.buf)
    end,
})

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "mermaid" then
        set_keymaps(buf)
    end
end
