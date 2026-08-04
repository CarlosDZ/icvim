return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    
    -- TYPESCRIPT -- 
    vim.lsp.config("ts_ls", {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
      root_markers = { "tsconfig.json", "package.json", ".git" },
      capabilities = capabilities,
    })

    -- C / C++ -- 
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
        "--function-arg-placeholders=0",
        "--query-driver=/usr/bin/gcc",
      },
      filetypes = { "c", "cpp" },
      root_markers = { ".clangd", "compile_commands.json", ".git" },
      capabilities = vim.tbl_deep_extend("force", capabilities, {
        offsetEncoding = { "utf-16" },
      }),
    })

    -- LUA --
    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          diagnostics = { globals = { "vim" } },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
    })
    

    vim.lsp.enable({ "ts_ls", "clangd", "lua_ls" })
  end,
}
