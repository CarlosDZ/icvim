local p = require("icvim.palette")

return {
  fill               = { bg = p.bg_bar, sp = p.border, underline = true },
  background         = { fg = p.comments,  bg = p.bg_bar },
  buffer_visible     = { fg = p.plaintext, bg = p.bg_bar },
  buffer_selected    = { fg = p.plaintext, bg = p.panels_bg, bold = true },

  numbers            = { fg = p.comments,  bg = p.bg_bar },
  numbers_visible    = { fg = p.comments,  bg = p.bg_bar },
  numbers_selected   = { fg = p.visual,    bg = p.panels_bg, bold = true },

  modified           = { fg = p.warning,   bg = p.bg_bar },
  modified_visible   = { fg = p.warning,   bg = p.bg_bar },
  modified_selected  = { fg = p.warning,   bg = p.panels_bg },

  separator          = { fg = p.bg_bar,        bg = p.bg_bar },
  separator_visible  = { fg = p.bg_bar,        bg = p.bg_bar },
  separator_selected = { fg = p.bg_bar,        bg = p.panels_bg },

  indicator_selected = { fg = p.visual,    bg = p.panels_bg },

  error              = { fg = p.error,     bg = p.bg_bar },
  error_selected     = { fg = p.error,     bg = p.panels_bg, bold = true },
  error_diagnostic   = { fg = p.error,     bg = p.bg_bar },
  warning            = { fg = p.warning,   bg = p.bg_bar },
  warning_selected   = { fg = p.warning,   bg = p.panels_bg, bold = true },
  warning_diagnostic = { fg = p.warning,   bg = p.bg_bar },

  offset_separator   = { fg = p.border,    bg = p.bg_bar },
}
