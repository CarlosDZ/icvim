return {
  require("plugins.indent"),
  require("plugins.blink"),
  require("plugins.lsp"),
  require("plugins.telescope"),
  require("plugins.alpha"),
  require("plugins.luasnip"),
  require("plugins.autopairs"),
  require("plugins.prettier"),
  require("plugins.bufferline"),
 {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {
        on_attach = require("config.keymaps").nvim_tree,
        view = {
          width = { min = 25, max = 50, padding = 2 },
        },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        reload_on_bufenter = true,
        filesystem_watchers = {
          enable = false,
        },
      }
    end,
  },

  {
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          theme = "gruvbox",
          section_separators = { "", "" },
          component_separators = { "", "" },
        },
      }
    end,
  },

  { "lewis6991/gitsigns.nvim" },

}
