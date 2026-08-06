vim.cmd("filetype plugin indent on")

vim.opt.fileformat = "unix"

vim.opt.guicursor = ""
vim.opt.colorcolumn = "120"
vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("autocmd BufEnter * set formatoptions-=cro | setlocal formatoptions-=cro")

-- keys
vim.opt.showcmd = true

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

local home = os.getenv("HOME") or os.getenv("USERPROFILE")
vim.opt.undodir = home .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.splitright = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})

vim.opt.history = 100

vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- Lsp
vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Show LSP Info" })
vim.api.nvim_create_user_command("LspLog", function(_)
    local state_path = vim.fn.stdpath("state")
    local log_path = vim.fs.joinpath(state_path, "lsp.log")
    vim.cmd(string.format("edit %s", log_path))
end, { desc = "Show LSP Log" })
vim.api.nvim_create_user_command("LspRestart", "lsp restart", { desc = "Restart LSP" })

-- Vim Pack
vim.api.nvim_create_user_command("PackUpdate", "lua vim.pack.update()", { desc = "Update Packages" })
