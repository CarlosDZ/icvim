return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
  opts = {
    keymap = require("config.keymaps").blink,
    snippets = { preset = "luasnip" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = false },
      list = {
        selection = { preselect = true, auto_insert = false },
      },
    },
    sources = {
      default = { "lsp", "snippets", "path" },
      min_keyword_length = 2,
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
