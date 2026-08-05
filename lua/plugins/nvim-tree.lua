return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
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
      git = {
        enable = true,
        ignore = false,
      },
      renderer = {
        highlight_git = "name",
        highlight_diagnostics = "icon",
        icons = {
          padding = "  ",
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = false,
            diagnostics = true,
          },
        },
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge   = "│",
            item   = "├",
            bottom = "─",
            none   = " ",
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        severity = {
          min = vim.diagnostic.severity.ERROR,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          error = "x",
          warning = "!",
          info = "i",
          hint = "?",
        },
      },
    })
  end,
}
