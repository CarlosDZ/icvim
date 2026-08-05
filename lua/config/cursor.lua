local blink = "blinkwait500-blinkon300-blinkoff300"

vim.opt.guicursor = table.concat({
  "n-c:block-CursorNormal-" .. blink,
  "v:block-CursorVisual-" .. blink,
  "i:ver25-CursorInsert-" .. blink,
}, ",")
