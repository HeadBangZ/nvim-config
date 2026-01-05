return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go",
    },
    keys = {
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
        { "<F5>",       function() require("dap").continue() end,          desc = "DAP: Continue/Start" },
        { "<F10>",      function() require("dap").step_over() end,         desc = "DAP: Step Over" },
        { "<F11>",      function() require("dap").step_into() end,         desc = "DAP: Step Into" },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        require("dap-go").setup()

        -- Automatically open/close UI
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end
}
