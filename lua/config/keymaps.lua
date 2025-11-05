vim.g.mapleader = " "

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', 'dd', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ch", function()
  local bufname = vim.fn.stdpath("config") .. "/cheatsheet.txt"
  local winid = nil

  -- Buscar si ya está abierta
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_name(buf) == bufname then
      winid = win
      break
    end
  end

  if winid then
    -- Si está abierta, ciérrala
    vim.api.nvim_win_close(winid, true)
  else
    -- Guardar ventana actual
    local current_win = vim.api.nvim_get_current_win()

    -- Abrir en split vertical
    local width = math.floor(vim.o.columns * 0.3)
    vim.cmd("vsplit " .. bufname)
    vim.cmd("wincmd L") -- Mover al extremo derecho
    vim.cmd("vertical resize " .. width)

    -- Configurar como solo lectura y sin swapfile
    vim.cmd("setlocal buftype=nofile bufhidden=hide noswapfile readonly")

    -- Volver al foco anterior
    vim.api.nvim_set_current_win(current_win)
  end
end, { desc = "Toggle cheatsheet" })


