local ok, diffview = pcall(require, "diffview")
if not ok then
  return
end

diffview.setup({})

local map = vim.keymap.set

map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git: [D]iffview [O]pen" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git: [F]ile [H]istory" })
map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Git: [D]iffview [Q]uit" })
