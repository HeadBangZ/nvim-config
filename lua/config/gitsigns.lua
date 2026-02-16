require("gitsigns").setup({})
vim.opt.statusline:append("%{get(b:,'gitsigns_status','')}")
