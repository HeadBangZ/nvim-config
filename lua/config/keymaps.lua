vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>cd", vim.cmd.Oil, { desc = "Oil: [O]pen" })
vim.keymap.set("n", "<leader>E", function()
        require("oil").open_float(vim.loop.cwd())
    end,
    { desc = "Oil: [O]pen [F]loat" })

vim.keymap.set("n", "<leader>t", "~", { desc = "[T]oggle [C]ase" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: [R]ename" })

vim.keymap.set("n", "<leader>i",
    function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
    end,
    { desc = "LSP: [I]nlay [H]ints" }
)

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP: [F]ormat [D]ocument", silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "[R]emove [H]ighlights", silent = true })

local opts = { noremap = true, silent = true }

-- scroll up and down and center when searching
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
-- vim.keymap.set("n", "x", '"_x', opts)

-- open window vertically and horizontally
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts)

-- resize window using arrow keys
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- search and replace
vim.keymap.set("v", "sr", [[:s/\%V]], { desc = "[R]ename [W]ithin [S]election" })

-- Marks
vim.keymap.set("n", "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "Fzf: [S]earch [A]ll [M]arks" })
vim.keymap.set("n", "<leader>cl", "<cmd>delmarks! | redrawstatus<cr>", { desc = "Marks: [C]lear [L]ocal" })
vim.keymap.set("n", "<leader>cg", "<cmd>delmarks A-Z | redrawstatus<cr>", { desc = "Marks: [C]lear [G]lobal" })

-- Move between windows
vim.keymap.set("t", "<C-h>", [[<C-\><C-n>h]], opts)
vim.keymap.set("t", "<C-j>", [[<C-\><C-n>j]], opts)
vim.keymap.set("t", "<C-k>", [[<C-\><C-n>k]], opts)
vim.keymap.set("t", "<C-l>", [[<C-\><C-n>l]], opts)

-- jump over closing pairs ) ] } ' "
vim.keymap.set("i", "<C-M-S-F8>", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local next_char = line:sub(col + 2, col + 2)

    if string.find(next_char, "[%)%]%}\"\'%>]") then
        return "<Right>"
    else
        return "<End>"
    end
end, { expr = true, desc = "[J]ump [O]ver [C]losing [P]airs" })
