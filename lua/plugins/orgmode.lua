require("orgmode").setup({
    org_agenda_files = "C:/Users/ThomasNordvigHermans/orgfiles/***/*",
    org_default_notes_file = "C:/Users/ThomasNordvigHermans/orgfiles/refile.org",

    org_capture_templates = {
        t = {
            description = "Task / TODO",
            template = "* TODO %?\n  CREATED: %U\n  LINK: %a",
            target = "C:/Users/ThomasNordvigHermans/orgfiles/tasks.org",
        },
        b = {
            description = "Bug Report",
            template =
            "* TODO [BUG] %?\n  CREATED: %U\n  - **Steps to reproduce:** \n  - **Expected:** \n  - **Actual:** \n  LINK: %a",
            target = "C:/Users/ThomasNordvigHermans/orgfiles/bugs.org",
        },
        m = {
            description = "Meeting Notes",
            template =
            "* %^{Meeting Title}\n  DATE: %U\n  ATTENDEES: %?\n\n** Agenda / Notes\n- \n\n** Action Items\n- [ ] ",
            target = "C:/Users/ThomasNordvigHermans/orgfiles/meetings.org",
        },
        j = {
            description = "Work Journal / Daily Standup",
            template = "* %U - %?\n** Done Yesterday\n- \n** Plan Today\n- \n** Blockers\n- ",
            target = "C:/Users/ThomasNordvigHermans/orgfiles/journal.org",
        },
    },
})

vim.lsp.enable("org")
