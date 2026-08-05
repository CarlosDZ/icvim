local M = {}

local servers = { "clangd", "lua_ls", "ts_ls" }

function M.setup()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  for _, name in ipairs(servers) do
    local config = require("lsp." .. name)
    config.capabilities = vim.tbl_deep_extend(
      "force", capabilities, config.capabilities or {}
    )
    vim.lsp.config(name, config)
  end

  vim.lsp.enable(servers)
end

return M
