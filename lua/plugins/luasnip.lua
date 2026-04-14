local ls = require("luasnip")
local types = require("luasnip.util.types")

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
        [types.choiceNode] = {
            active = { virt_text = { { "●", "GhostCharacter" } } },
        },
    },
})

-- vim.keymap.set({ "i", "s" }, "<C-h>", function()
--     if ls.expand_or_jumpable() then
--         ls.expand_or_jump()
--     end
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-l>", function()
--     if ls.jumpable(-1) then
--         ls.jump(-1)
--     end
-- end, { silent = true })
