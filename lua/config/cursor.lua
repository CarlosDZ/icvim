local colors = {
  normal = "#ffffff",
  insert = "#ffcc00",
  visual = "#00ccff",
}

local function define_cursor_hl()
  vim.api.nvim_set_hl(0, "CursorNormal", { bg = "#ffffff", fg = "#000000" })
  vim.api.nvim_set_hl(0, "CursorInsert", { bg = "#ffcc00", fg = "#000000" })
  vim.api.nvim_set_hl(0, "CursorVisual", { bg = "#00ccff", fg = "#000000" })
end

define_cursor_hl()
-- Cursor redefinition after colorscheme loads.
vim.api.nvim_create_autocmd("ColorScheme", { callback = define_cursor_hl })

local blink = "blinkwait500-blinkon300-blinkoff300"
vim.opt.guicursor = table.concat({
  "n-v-c:block-CursorNormal-" .. blink,
  "i:ver25-CursorInsert-" .. blink,
}, ",")
