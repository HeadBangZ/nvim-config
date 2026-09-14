vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = 'None' })

require("render-markdown").setup({
    completions = {
        blink = { enabled = true },
        lsp = { enabled = true }
    },
})

local map = vim.keymap.set

map("n", "<leader>rmt", "<cmd>RenderMarkdown toggle<CR>", { desc = "RenderMarkdown: [T]oggle" })
map("n", "<leader>rmT", "<cmd>RenderMarkdown buf_toggle<CR>", { desc = "RenderMarkdown: [T]oggle [B]uffer" })
map("n", "<leader>rme", "<cmd>RenderMarkdown enable<CR>", { desc = "RenderMarkdown: [E]nable" })
map("n", "<leader>rmd", "<cmd>RenderMarkdown disable<CR>", { desc = "RenderMarkdown: [D]isable" })
map("n", "<leader>rmp", "<cmd>RenderMarkdown preview<CR>", { desc = "RenderMarkdown: [P]review" })
map("n", "<leader>rml", "<cmd>RenderMarkdown log<CR>", { desc = "RenderMarkdown: Open [L]og" })
map("n", "<leader>rmc", "<cmd>RenderMarkdown config<CR>", { desc = "RenderMarkdown: Show [C]onfig" })
map("n", "<leader>rmg", "<cmd>RenderMarkdown debug<CR>", { desc = "RenderMarkdown: [D]ebug Line" })
map("n", "<leader>rm+", "<cmd>RenderMarkdown expand<CR>", { desc = "RenderMarkdown: [E]xpand Margin" })
map("n", "<leader>rm-", "<cmd>RenderMarkdown contract<CR>", { desc = "RenderMarkdown: [C]ontract Margin" })
