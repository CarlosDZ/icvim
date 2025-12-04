return {
  require("plugins.alpha"),
  require("plugins.indent"),
  require("plugins.cmp"),
  require("plugins.lsp"),
  require("plugins.emmet"),
  require("plugins.luasnip"),
  require("plugins.autopairs"),
  require("plugins.autotag"),
  require("plugins.prettier"),
  require("plugins.treesitter"),
  { "tpope/vim-sensible" },
  { "hrsh7th/nvim-cmp" },
  { "neovim/nvim-lspconfig" },
  { "L3MON4D3/LuaSnip" },
  { "gruvbox-community/gruvbox" },
  { "hrsh7th/nvim-cmp" },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {}
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

  {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("telescope").setup {}
    pcall(require("telescope").load_extension, "file_browser")
  end,
  },


  { "lewis6991/gitsigns.nvim" },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  }
}
