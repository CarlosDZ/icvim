return {
  "MunifTanjim/prettier.nvim",
  config = function()
    require("prettier").setup({
      bin = "prettier", -- usa el binario de Prettier instalado en tu sistema/proyecto
      filetypes = {
        "javascript", "typescript", "css", "html", "json", "vue", "yaml", "markdown"
      },
    })

    -- Autoformatear al guardar
    vim.cmd [[autocmd BufWritePre *.js,*.ts,*.vue,*.css,*.html,*.json Prettier]]
  end,
}

