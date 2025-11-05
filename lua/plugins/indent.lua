return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
      highlight = {
        "IndentScope1",
        "IndentScope2",
        "IndentScope3",
        "IndentScope4",
        "IndentScope5",
      }
    },
    
    scope = {
      enabled = true,
      show_start = false,
      show_end = false  
    },
    exclude = {
      filetypes = { "help", "dashboard", "alpha", "NvimTree", "lazy" },
      buftypes = { "terminal", "nofile" },
    },
  },
}

