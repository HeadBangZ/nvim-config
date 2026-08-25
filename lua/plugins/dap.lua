local dap = require("dap")
local dapui = require("dapui")

-- Setup UI
dapui.setup()

-- Automatically open/close UI when debugging starts/ends
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Keymaps
vim.keymap.set("n", "<F1>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

-------------------------------------------------------------------------------
-- 1. Python (debugpy)
-------------------------------------------------------------------------------
dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return "python"
        end,
    },
}

-------------------------------------------------------------------------------
-- 2. Go (Delve)
-------------------------------------------------------------------------------
dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
    },
}

dap.configurations.go = {
    {
        type = "go",
        name = "Debug File",
        request = "launch",
        program = "${file}",
    },
    {
        type = "go",
        name = "Debug Package",
        request = "launch",
        program = "${fileDirname}",
    },
}

-------------------------------------------------------------------------------
-- 3. C# (netcoredbg)
-------------------------------------------------------------------------------
dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
    },
}
