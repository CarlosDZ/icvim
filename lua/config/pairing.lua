local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

-- Inicio el plugin
npairs.setup({})

-- Reglas generales
npairs.add_rules({
  Rule('"', '"'),
  Rule("(", ")"),
  Rule("[", "]"),
  Rule("{", "}"),
})

-- Reglas HTML
npairs.add_rules({
  Rule("<", ">", "html")
})
