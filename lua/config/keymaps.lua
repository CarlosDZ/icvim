-- ════════════════════════════════════════════════════════════════════
--  KEYBINDINGS
-- ════════════════════════════════════════════════════════════════════

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- ══ Editing ═════════════════════════════════════════════════════════
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
map("n", "<A-h>", "<<",           { desc = "Unindent line" })
map("n", "<A-l>", ">>",           { desc = "Indent line" })

map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "Move line down" })
map("i", "<A-h>", "<C-d>", { desc = "Unindent line" })
map("i", "<A-l>", "<C-t>", { desc = "Indent line" })

map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move block up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move block down" })
map("v", "<A-h>", "<gv", { desc = "Unindent block" })
map("v", "<A-l>", ">gv", { desc = "Indent block" })

map("x", "p", function()
  if vim.fn.mode() == "V" then
    local reg = vim.fn.getreg('"')
    local regtype = vim.fn.getregtype('"')
    vim.schedule(function()
      vim.fn.setreg('"', reg, regtype)
    end)
    return "p"
  end
  return "P"
end, { expr = true, desc = "Paste without yanking replaced text" })

map({ "n", "v" }, "d", '"_d', { desc = "Delete" })
map({ "n", "v" }, "D", '"_D', { desc = "Delete to end of line" })
map("n", "x", '"_x', { desc = "Delete char under cursor" })
map("n", "X", '"_X', { desc = "Delete char before cursor" })

map({ "n", "v" }, "<leader>x", "d", { desc = "Cut" })
map("n", "<leader>xx", "dd", { desc = "Cut line" })

map("n", "J", "mzJ`z", { desc = "Join lines, keep cursor" })
map("n", "<leader>o", "o<Esc>", { desc = "Blank line below WO entering insert mode" })

-- ══ Navigation ══════════════════════════════════════════════════════
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

map({ "n", "v" }, "H", "^", { desc = "Start of line" })
map({ "n", "v" }, "L", "$", { desc = "End of line" })

 -- ══ Windows ═════════════════════════════════════════════════════════
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<C-S-h>", "<C-w><", { desc = "Resize window left" })
map("n", "<C-S-j>", "<C-w>-", { desc = "Resize window down" })
map("n", "<C-S-k>", "<C-w>+", { desc = "Resize window up" })
map("n", "<C-S-l>", "<C-w>>", { desc = "Resize window right" })

map("n", "<leader>i", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>-", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader><BS>", "<C-w>c", { desc = "Close window" })
map("n", "<leader>m", "<C-w>=", { desc = "Equalize windows" })

-- ══ Buffers ═════════════════════════════════════════════════════════
map("n", "<Tab>", "<C-6>", { desc = "Alternate buffer" })

map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>",  { silent = true, desc = "Buffer 1" })
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>",  { silent = true, desc = "Buffer 2" })
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>",  { silent = true, desc = "Buffer 3" })
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>",  { silent = true, desc = "Buffer 4" })
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>",  { silent = true, desc = "Buffer 5" })
map("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>",  { silent = true, desc = "Buffer 6" })
map("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>",  { silent = true, desc = "Buffer 7" })
map("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>",  { silent = true, desc = "Buffer 8" })
map("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>",  { silent = true, desc = "Buffer 9" })
map("n", "<A-0>", ":BufferLineGoToBuffer 10<CR>", { silent = true, desc = "Buffer 10" })

map("n", "<A-BS>", function()
  local cur = vim.api.nvim_get_current_buf()

  if vim.bo[cur].modified then
    vim.notify("Buffer modificado: guarda o usa :bd!", vim.log.levels.WARN)
    return
  end

  local listed = vim.tbl_filter(function(b)
    return vim.bo[b].buflisted
  end, vim.api.nvim_list_bufs())

  if #listed > 1 then
    vim.cmd("BufferLineCyclePrev")
  end

  pcall(vim.api.nvim_buf_delete, cur, {})
end, { silent = true, desc = "Delete buffer" })

-- ══ Explorer ════════════════════════════════════════════════════════
map("n", "<leader>e", ":NvimTreeToggle<CR>",   { silent = true, desc = "Toggle file explorer" })
map("n", "<leader>E", ":NvimTreeCollapse<CR>", { silent = true, desc = "Collapse file explorer dirs"})

-- ══ Find (f) ════════════════════════════════════════════════════════
map("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>",  { silent = true, desc = "Grep contents" })
map("n", "<leader>fb", ":Telescope buffers<CR>",    { silent = true, desc = "Find buffers" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>",   { silent = true, desc = "Recent files" })
map("n", "<leader>fs", ":Telescope resume<CR>", { silent = true, desc = "Resume last search" })
map("n", "<leader>fo", ":Telescope lsp_document_symbols<CR>", { silent = true, desc = "Document symbols" })
map("n", "<leader>fw", ":Telescope grep_string<CR>", { silent = true, desc = "Grep word under cursor" })
map("n", "<leader>fk", ":Telescope keymaps<CR>", { silent = true, desc = "Search keymaps" })

-- ══ LSP (l) ═════════════════════════════════════════════════════════
map("n", "?", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("i", "<C-s>", function()
  vim.lsp.buf.signature_help({ focusable = false })
end, { desc = "Signature help" })

map("n", "grd", vim.lsp.buf.definition,      { desc = "Go to definition" })
map("n", "gri", vim.lsp.buf.implementation,  { desc = "Go to implementation" })
map("n", "grt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

map("n", "grr", ":Telescope lsp_references<CR>", { silent = true, desc = "List references" })
map("n", "grn", vim.lsp.buf.rename,          { desc = "Rename symbol" })
map({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "Code action" })

map("n", "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format buffer" })

-- ══ Diagnostics (d) ═════════════════════════════════════════════════
map("n", "<leader>qq", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
map("n", "<leader>ql", ":Telescope diagnostics<CR>", { silent = true, desc = "List diagnostics" })
map("n", "<leader>qv", function()
  local enabled = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not enabled and { spacing = 2, prefix = "●" } or false })
end, { desc = "Toggle virtual text" })

-- ══ Utilities ═══════════════════════════════════════════════════════
map("n", "<leader>ch", require("config.cheatsheet").toggle, { desc = "Toggle cheatsheet" })

local M = {} -- This is necessary for the plugin sections
-- ══ blink.cmp ═══════════════════════════════════════════════════════
M.blink = {
  preset = "none",
  ["<C-j>"]     = { "select_next", "fallback" },
  ["<C-k>"]     = { "select_prev", "fallback" },
  ["<Tab>"]     = { "accept", "snippet_forward", "fallback" },
  ["<S-Tab>"]   = { "snippet_backward", "fallback" },
  ["<CR>"]      = { "accept", "fallback" },
  ["<C-Space>"] = { "show", "hide" },
  ["<C-e>"]     = { "cancel", "fallback" },
  ["<C-b>"]     = { "scroll_documentation_up", "fallback" },
  ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
}

-- ══ nvim-tree ═══════════════════════════════════════════════════════
M.nvim_tree = function(bufnr)
  local api = require("nvim-tree.api")
  local opts = function(desc)
    return { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc }
  end

  local system_types = {
    pdf = true, epub = true, djvu = true,
    png = true, jpg = true, jpeg = true, gif = true, webp = true, bmp = true, ico = true,
    mp4 = true, mkv = true, webm = true, avi = true, mov = true,
    mp3 = true, flac = true, wav = true, ogg = true, opus = true,
    odt = true, ods = true, odp = true, docx = true, xlsx = true, pptx = true,
    zip = true, tar = true, gz = true, xz = true, zst = true, ["7z"] = true, rar = true,
  }

  local function smart_open()
    local node = api.tree.get_node_under_cursor()
    if not node or node.type == "directory" then
      api.node.open.edit()
      return
    end
    local ext = node.name:match("%.([^.]+)$")
    if ext and system_types[ext:lower()] then
      api.node.run.system()
    else
      api.node.open.edit()
    end
  end

  map("n", "<CR>", smart_open,       opts("Open"))
  map("n", "\\",   api.node.open.preview,    opts("Preview"))
  map("n", "i",    api.node.open.vertical,   opts("Open in vertical split"))
  map("n", "-",    api.node.open.horizontal, opts("Open in horizontal split"))
  map("n", "s",    api.node.run.system,      opts("Open with system app"))
  map("n", "S",    api.node.open.edit,       opts("Force open in editor"))
  
  map("n", "[", api.tree.change_root_to_parent, opts("Go up one directory"))
  map("n", "]", api.tree.change_root_to_node,   opts("Set directory as root"))
  map("n", "<BS>", api.node.navigate.parent_close, opts("Close directory"))
  map("n", "h", api.node.navigate.parent_close, opts("Close directory"))
  map("n", "l", smart_open,                     opts("Open"))

  map("n", "a", api.fs.create,               opts("Create file or directory"))
  map("n", "d", api.fs.remove,               opts("Delete"))
  map("n", "r", api.fs.rename_full,          opts("Rename (full path)"))
  map("n", "x", api.fs.cut,                  opts("Cut"))
  map("n", "c", api.fs.copy.node,            opts("Copy"))
  map("n", "p", api.fs.paste,                opts("Paste"))
  map("n", "y", api.fs.copy.absolute_path,   opts("Copy absolute path")) 

  map("n", "H", api.tree.toggle_hidden_filter, opts("Toggle hidden files"))
  map("n", "f", api.live_filter.start,         opts("Live filter"))
  map("n", "F", api.live_filter.clear,         opts("Clear live filter")) 
end

-- ══ alpha ═══════════════════════════════════════════════════════════
M.alpha = {
  { "a", "New file", ":ene <BAR> startinsert <CR>" },
  { "f", "File explorer", ":lua select_dir_and_open_tree()<CR>" },
  { "r", "Recent files", ":Telescope oldfiles<CR>" },
  { "c", "Configuration", ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>" },
  { "q", "Quit", ":qa<CR>" },
}

-- ══ telescope file_browser ══════════════════════════════════════════
M.telescope_file_browser = function(fb, open_dir_or_file)
  return {
    n = {
      ["<CR>"] = open_dir_or_file,
      ["h"]    = fb.goto_parent_dir,
      ["l"]    = open_dir_or_file,
      ["H"]    = fb.toggle_hidden,
      ["a"]    = fb.create,
      ["d"]    = fb.remove,
      ["r"]    = fb.rename,
      ["y"]    = fb.copy,
      ["x"]    = fb.move,
      ["."]    = fb.goto_cwd,
      ["~"]    = fb.goto_home_dir,
    },
  }
end

-- ══ Git ═════════════════════════════════════════════════════════════
map("n", "]c", ":Gitsigns next_hunk<CR>",    { silent = true, desc = "Next hunk" })
map("n", "[c", ":Gitsigns prev_hunk<CR>",    { silent = true, desc = "Previous hunk" })
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { silent = true, desc = "Preview hunk" })
map("n", "<leader>gb", ":Gitsigns blame_line<CR>",   { silent = true, desc = "Blame line (full)" })
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { silent = true, desc = "Toggle inline blame" })

-- IF YOU PUT CODE BELOW THE RETURN M YOUR NVIM CRASHES MY GUY THIS IS THE END OF THE FILE WRITE EVERYTHING THERE ^^^^^^^^^ TYSM FOR THE ATTENTION
return M 
