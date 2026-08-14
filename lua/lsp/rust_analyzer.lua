return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        buildScripts = { enable = true },
      },
      procMacro = { enable = true },
      checkOnSave = true,
      check = { command = "clippy" },
      inlayHints = {
        bindingModeHints = { enable = false },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "skip_trivial" },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
}
