return {
  "hoob3rt/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = require("icvim.lualine"),
        section_separators = { "", "" },
        component_separators = { "", "" },
      },
    })
  end,
}
