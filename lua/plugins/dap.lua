return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go",
        "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
        { "<F5>",       function() require("dap").continue() end,          desc = "Continue" },
        { "<F10>",      function() require("dap").step_over() end,         desc = "Step Over" },
        { "<F11>",      function() require("dap").step_into() end,         desc = "Step Into" },
        {
            "<leader>dh",
            function() require("dap.ui.widgets").hover(nil, { border = "rounded" }) end,
            desc = "Hover Value"
        },
        {
            "<leader>ds",
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes, { border = "rounded" })
            end,
            desc = "Scopes (Large Float)"
        },
        { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle Full UI" },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        require("nvim-dap-virtual-text").setup()
        require("dap-go").setup()

        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end
}
