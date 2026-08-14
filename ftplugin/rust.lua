vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

vim.bo.commentstring = "// %s"

pcall(vim.treesitter.start)
