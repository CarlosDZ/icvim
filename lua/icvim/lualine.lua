local p = require("icvim.palette")

local function mode(accent)
  return {
    a = { bg = accent,      fg = p.bg, gui = "bold" },
    b = { bg = p.panels_bg, fg = p.plaintext },
    c = { bg = p.bg_bar,    fg = p.comments },
  }
end

return {
  normal   = mode(p.normal),
  insert   = mode(p.insert),
  visual   = mode(p.visual),
  replace  = mode(p.error),
  command  = mode(p.functions),
  inactive = {
    a = { bg = p.bg_bar, fg = p.comments },
    b = { bg = p.bg_bar, fg = p.comments },
    c = { bg = p.bg_bar, fg = p.comments },
  },
}
