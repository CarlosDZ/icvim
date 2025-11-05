return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config.ts_ls = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
      root_dir = vim.fs.dirname(vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { upward = true })[1]),
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    }

    vim.lsp.enable("ts_ls")
  end,
}

