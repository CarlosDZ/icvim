return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      highlights = require("icvim.bufferline"),
      options = {
        mode = "buffers",
        numbers = function(opts)
          return string.format("%s", opts.ordinal)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = "thin",
        offsets = {
          {
            filetype = "NvimTree",
            text = "Files",
            highlight = "Directory",
            separator = true,
          },
        },
        custom_filter = function(buf)
          local name = vim.api.nvim_buf_get_name(buf)
          if name:match("^/usr/include/") then return false end
          if name:match("^/usr/lib/") then return false end
          if name:match("^/usr/src/") then return false end
          return true
        end,
      },
    })
  end,
}
