return {
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
    init = function()
      -- activa Emmet en Insert y Visual
      vim.g.user_emmet_mode = "iv"
      -- trigger por defecto: Ctrl+y ,
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
    config = function()
      -- no necesitas redefinir nada si usas el trigger original
      -- pero puedes comprobar que los mapeos existen con:
      -- :imap <C-y>,
      -- :imap <C-y><C-y>
    end,
  },
}

