local M = {}

function M.toggle()
  local bufname = vim.fn.stdpath("config") .. "/cheatsheet.md"
  local winid = nil

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_name(buf) == bufname then
      winid = win
      break
    end
  end

  if winid then
    vim.api.nvim_win_close(winid, true)
  else
    local current_win = vim.api.nvim_get_current_win()
    local width = math.floor(vim.o.columns * 0.3)
    vim.cmd("vsplit " .. bufname)
    vim.cmd("wincmd L")
    vim.cmd("vertical resize " .. width)
    vim.cmd("setlocal buftype=nofile bufhidden=hide noswapfile readonly")
    vim.api.nvim_set_current_win(current_win)
  end
end

return M
