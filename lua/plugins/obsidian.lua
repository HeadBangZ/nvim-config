local status, obsidian = pcall(require, "obsidian")
if not status then
    return
end

obsidian.setup({
    legacy_commands = false,
    workspaces = {
        {
            name = "work",
            path = "~/obsidian",
        },
    },
    notes_subdir = "notes",
    daily_notes = {
        folder = "journals",
        date_format = "%d-%m-%Y",
        template = "journal-template.md",
    },

    templates = {
        folder = "templates",
        date_format = "%d-%m-%Y",
        time_format = "%H:%M",
        substitutions = {},
    },

    finder = "fzf-lua",
    ui = {
        enable = false,
    },
})

local map = vim.keymap.set

map("n", "<leader>oj", "<cmd>Obsidian today<cr>", { desc = "Open Today's Journal" })

map("n", "<leader>oi", function()
    local title = vim.fn.input("Idea Title: ")
    if title ~= "" then
        vim.cmd("Obsidian new_from_template " .. vim.fn.fnameescape(title) .. " idea-template.md")
    end
end, { desc = "New Idea Note" })

map("n", "<leader>ot", function()
    local title = vim.fn.input("Task Title: ")
    if title ~= "" then
        vim.cmd("Obsidian new_from_template " .. vim.fn.fnameescape(title) .. " task-template.md")
    end
end, { desc = "New Task Note" })

map("n", "<leader>on", function()
    local title = vim.fn.input("Note Title: ")
    if title ~= "" then
        vim.cmd("Obsidian new_from_template " .. vim.fn.fnameescape(title) .. " note-template.md")
    end
end, { desc = "New Standard Note" })

map("n", "<leader>opt", "<cmd>Obsidian new_from_template<cr>", { desc = "New Note (Pick Template)" })
