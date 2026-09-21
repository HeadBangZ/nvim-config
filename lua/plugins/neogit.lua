local neogit

local function get_neogit()
    if not neogit then
        local ok, mod = pcall(require, "neogit")
        if not ok then
            return nil
        end

        mod.setup({
            integrations = {
                diffview = true,
                fzf_lua = true,
            },
        })

        neogit = mod
    end

    return neogit
end

local function open_neogit()
    local ng = get_neogit()
    if ng then
        ng.open()
    end
end

local function toggle_neogit()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "NeogitStatus" then
            vim.api.nvim_win_close(win, false)
            return
        end
    end

    open_neogit()
end

local map = vim.keymap.set

map("n", "<C-M-S-F8>", toggle_neogit, { desc = "Git: [T]oggle [N]eogit [W]indow" })
