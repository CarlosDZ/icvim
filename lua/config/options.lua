vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.showmode = false
vim.opt.hlsearch = true
vim.opt.selection = "exclusive" 
vim.o.winborder = "rounded"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.updatetime = 250

vim.diagnostic.config({
  virtual_text = { spacing = 3, prefix = "-" },
  severity_sort = true,
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "x",
      [vim.diagnostic.severity.WARN]  = "!",
      [vim.diagnostic.severity.INFO]  = "i",
      [vim.diagnostic.severity.HINT]  = "?",
    },
  },
})


-- Clipboard
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = { "wl-copy", "--type", "text/plain" },
    ["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
  },
  paste = {
    ["+"] = { "wl-paste", "--no-newline" },
    ["*"] = { "wl-paste", "--primary", "--no-newline" },
  },
  cache_enabled = 1,
}
vim.opt.clipboard = "unnamedplus"


-- Command timeout
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

-- Providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
