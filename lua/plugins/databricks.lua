local loaded = false

local function ensure_loaded()
    if loaded then
        return true
    end

    local ok, databricks = pcall(require, "databricks")
    if not ok then
        return false
    end

    databricks.setup({
        profile = "DEFAULT",
        cluster_id = nil,
        upload_path = "dbfs:/tmp/databricks-nvim",
        poll_interval_ms = 5000,
        output_position = "botright",
        output_height = 15,
        keymap_prefix = false,
    })
    loaded = true

    return true
end

local function cmd(command)
    return function()
        if ensure_loaded() then
            vim.cmd(command)
        end
    end
end

local map = vim.keymap.set

map("n", "<leader>Dr", cmd("DatabricksRun"), { desc = "Databricks: [R]un [F]ile" })
map("n", "<leader>Dc", cmd("DatabricksClusterSelect"), { desc = "Databricks: [S]elect [C]luster" })
map("n", "<leader>Dl", cmd("DatabricksClusterList"), { desc = "Databricks: [L]ist [C]lusters" })
map("n", "<leader>Do", cmd("DatabricksOutput"), { desc = "Databricks: [S]how [O]utput" })
