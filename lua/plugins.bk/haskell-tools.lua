return {
    "mrcjkb/haskell-tools.nvim",
    version = "^4",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    init = function()
        vim.g.haskell_tools = {
            hls = {
                settings = {
                    haskell = {
                        formattingProvider = "ormolu",
                        checkProject = true,
                    },
                },
                on_attach = function(client, bufnr)
                    local ht = require('haskell-tools')
                    local opts = { noremap = true, silent = true, buffer = bufnr }

                    local keymaps = require("core.lsp.keymaps")
                    keymaps.on_attach(client, bufnr)

                    vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
                    vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
                    vim.keymap.set('n', '<space>hp', ht.project.open_package_yaml, opts)
                end,
            },
        }
    end,
    config = function()
    end
}
