-- ════════════════════════════════════════════════════════════════════
--  USER COMMANDS
-- ════════════════════════════════════════════════════════════════════

-- ══ :W — write and close buffer ═════════════════════════════════════
vim.api.nvim_create_user_command("W", function()
  vim.cmd("write")
  local listed = vim.tbl_filter(function(b)
    return vim.bo[b].buflisted
  end, vim.api.nvim_list_bufs())
  if #listed > 1 then
    local cur = vim.api.nvim_get_current_buf()
    vim.cmd("BufferLineCyclePrev")
    vim.api.nvim_buf_delete(cur, {})
  else
    vim.cmd("quit")
  end
end, { desc = "Write and close buffer" })

-- ══ :ThemeReload — reapply theme from palette ═══════════════════════
vim.api.nvim_create_user_command("ThemeReload", function()
  for _, mod in ipairs({
    "icvim.palette",
    "icvim.theme",
    "icvim.lualine",
    "icvim.bufferline",
  }) do
    package.loaded[mod] = nil
  end

  require("icvim.theme")

  local ok, lualine = pcall(require, "lualine")
  if ok then
    lualine.setup({
      options = {
        theme = require("icvim.lualine"),
        section_separators = { "", "" },
        component_separators = { "", "" },
      },
    })
  end

  vim.notify("Theme reloaded", vim.log.levels.INFO)
end, { desc = "Reload theme from palette" })
