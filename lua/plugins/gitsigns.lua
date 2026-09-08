local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  return
end

gitsigns.setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]h", function() gs.nav_hunk("next") end, { desc = "[N]ext [H]unk" })
    map("n", "[h", function() gs.nav_hunk("prev") end, { desc = "[P]rev [H]unk" })

    -- Actions
    map("n", "<leader>gp", gs.preview_hunk, { desc = "Git: [P]review [H]unk" })
    map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Git: [B]lame [L]ine" })
  end,
})
