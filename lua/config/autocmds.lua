-- ════════════════════════════════════════════════════════════════════ 
-- AUTOCOMMANDS
-- ════════════════════════════════════════════════════════════════════

-- ══ Search highlight ════════════════════════════════════════════════
local ns = vim.api.nvim_create_namespace("auto_hlsearch")

vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local keep = { "<CR>", "n", "N", "*", "#", "/" }
    local should_keep = vim.tbl_contains(keep, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= should_keep then
      vim.opt.hlsearch = should_keep
    end
  end
end, ns)

-- ══ External dependencies ═══════════════════════════════════════════
vim.schedule(function()
  if vim.fn.executable("wl-copy") == 0 then
    vim.notify("wl-clipboard not found: no system clipboard", vim.log.levels.WARN)
  end
end)

-- ══ LSP signature help ══════════════════════════════════════════════
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method("textDocument/signatureHelp") then
      return
    end
    local chars = client.server_capabilities.signatureHelpProvider
      and client.server_capabilities.signatureHelpProvider.triggerCharacters
      or { "(", "," }

    vim.api.nvim_create_autocmd("InsertCharPre", {
      buffer = args.buf,
      callback = function()
        if vim.v.char == "(" or vim.v.char == "," then
          vim.defer_fn(function()
            vim.lsp.buf.signature_help({ focusable = false})
          end, 100)
        end
      end,
    })
  end,
})

-- ══ Treesitter (native parsers) ═════════════════════════════════════
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "lua", "markdown", "vim", "query" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- ══ Format on save (LSP) ════════════════════════════════════════════
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or not client:supports_method("textDocument/formatting") then
      return
    end
    if not vim.tbl_contains({ "c", "cpp" }, vim.bo[args.buf].filetype) then
      return
    end
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 2000 })
      end,
    })
  end,
})

-- ══ Close buffer when its last window closes ════════════════════════
vim.api.nvim_create_autocmd("WinClosed", {
  callback = function(args)
    local win = tonumber(args.match)
    local buf = vim.api.nvim_win_get_buf(win)

    if vim.bo[buf].buftype ~= "" then return end

    local others = vim.tbl_filter(function(w)
      return w ~= win and vim.api.nvim_win_get_buf(w) == buf
    end, vim.api.nvim_list_wins())

    if #others == 0 then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
      end)
    end
  end,
})
