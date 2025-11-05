vim.opt.guicursor = "n:ver25-blinkon300-blinkoff300-blinkwait500,i:ver25-blinkon300-blinkoff300-blinkwait500,v:ver25-blinkon300-blinkoff300-blinkwait500"

vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    local mode = vim.fn.mode()
    local file = vim.fn.expand("~/.config/kitty/cursor-normal.conf")

    if mode == "i" then
      file = vim.fn.expand("~/.config/kitty/cursor-insert.conf")
    elseif mode == "v" or mode == "V" or mode == "\22" then
      file = vim.fn.expand("~/.config/kitty/cursor-visual.conf")
    end

    local socket = vim.fn.getenv("KITTY_LISTEN_ON")
    if socket and socket ~= "" then
      local cmd = string.format("kitty @ --to '%s' set-colors --all '%s'", socket, file)
      os.execute(cmd)
    end
  end
})
