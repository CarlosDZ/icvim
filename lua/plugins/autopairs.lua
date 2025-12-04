return {
  "windwp/nvim-autopairs",
  dependencies = { "nvim-treesitter/nvim-treesitter", "windwp/nvim-ts-autotag" },
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true,
    })

    require("nvim-ts-autotag").setup()
  end,
}

