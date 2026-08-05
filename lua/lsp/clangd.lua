return {
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
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
}
