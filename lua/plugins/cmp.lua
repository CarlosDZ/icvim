return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 }),
      },
       sorting = {
    priority_weight = 2,
    comparators = {
      function(entry1, entry2)
        local input = cmp.get_config().completion.keyword_pattern
        local label1 = entry1.completion_item.label
        local label2 = entry2.completion_item.label
        local match1 = label1:find("^" .. input)
        local match2 = label2:find("^" .. input)
        if match1 and not match2 then
          return true
        elseif not match1 and match2 then
          return false
        end
      end,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
            },
        },
    })
  end,
}
