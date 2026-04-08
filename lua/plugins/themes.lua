local active_theme = "vesper"

if active_theme == "everforest" then
    vim.g.everforest_transparent_background = 1
elseif active_theme == "rose-pine" then
    local ok, rose_pine = pcall(require, "rose-pine")
    if ok then
        rose_pine.setup({ styles = { transparency = true } })
    end
elseif active_theme == "vesper" then
    local ok, vesper = pcall(require, "vesper")
    if ok then
        vesper.setup({ transparent = true })
    end
end

local ok_scheme, _ = pcall(vim.cmd.colorscheme, active_theme)

if ok_scheme then
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
else
    print("Theme not found: " .. active_theme)
end
