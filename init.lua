vim.loader.enable()

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmd")
require("core.lsp")
-- vim.lsp.set_log_level("debug")
