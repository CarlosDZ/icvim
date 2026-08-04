local colors = {
  IndentScope1 = "#d75f5f",
  IndentScope2 = "#afaf00",
  IndentScope3 = "#5fafd7",
  IndentScope4 = "#87af5f",
  IndentScope5 = "#d787af",
}

local function apply()
  for group, fg in pairs(colors) do
    vim.api.nvim_set_hl(0, group, { fg = fg, nocombine = true })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })
apply()
