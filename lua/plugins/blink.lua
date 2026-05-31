local blink = require("blink.cmp")

-- blink.build():wait(60000)

blink.setup({
    keymap = {
        preset = 'none',

        -- Navigation
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        -- Actions
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'accept', 'fallback' },
        ['<C-j>'] = { 'show', 'fallback' },
        -- Jumps
        ['<C-h>'] = { 'snippet_forward', 'fallback' },
        ['<C-l>'] = { 'snippet_backward', 'fallback' },
        -- Scroll documentation up
        ['<C-b>'] = { 'scroll_documentation_up' },
        -- Scroll documentation down
        ['<C-f>'] = { 'scroll_documentation_down' },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
        accept = {
            auto_brackets = { enabled = true },
        },

        menu = {
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            draw = {
                columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            },
        },
        documentation = {
            window = {
                border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                max_width = 100,
                max_height = 30,
            },
            auto_show = true,
            auto_show_delay_ms = 250,
        },
        ghost_text = { enabled = true },
    },

    signature = {
        enabled = true,
        window = {
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        }
    },

    snippets = {
        preset = 'luasnip'
    },

    fuzzy = {
        implementation = 'prefer_rust_with_warning'
    }
})
