vim.g.molten_image_provider = "none"

vim.g.molten_auto_open_output = true
vim.g.molten_output_win_max_height = 12
vim.g.molten_wrap_output = true

local opts = { silent = true }
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", opts)
vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", opts)
vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", opts)
vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>", opts)
vim.keymap.set("n", "<leader>rc", ":MoltenReevaluateCell<CR>", opts)
vim.keymap.set("n", "<leader>ro", ":MoltenHideOutput<CR>", opts)
vim.keymap.set("n", "<leader>so", ":MoltenShowOutput<CR>", opts)
