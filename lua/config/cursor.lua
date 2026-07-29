local colors = {
  normal = "#ffffff",
  insert = "#ffcc00",
  visual = "#00ccff",
}

local function define_cursor_hl()
  vim.api.nvim_set_hl(0, "CursorNormal", { bg = colors.normal })
  vim.api.nvim_set_hl(0, "CursorInsert", { bg = colors.insert })
  vim.api.nvim_set_hl(0, "CursorVisual", { bg = colors.visual })
end

define_cursor_hl()
-- Cursor redefinition after colorscheme loads.
vim.api.nvim_create_autocmd("ColorScheme", { callback = define_cursor_hl })

local blink = "blinkwait500-blinkon300-blinkoff300"
vim.opt.guicursor = table.concat({
  "n-c:ver25-CursorNormal-" .. blink,
  "i:ver25-CursorInsert-" .. blink,
  "v:ver25-CursorVisual-" .. blink,
}, ",")
