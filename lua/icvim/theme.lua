-- ════════════════════════════════════════════════════════════════════
--  THEME
-- ════════════════════════════════════════════════════════════════════

local p = require("icvim.palette")

local function apply()
  local hl = vim.api.nvim_set_hl

  -- ══ Base ══════════════════════════════════════════════════════════
  hl(0, "Normal",      { fg = p.plaintext, bg = p.bg })
  hl(0, "NormalFloat", { fg = p.plaintext, bg = p.panels_bg })
  hl(0, "FloatBorder", { bg = p.panels_bg })
  hl(0, "Comment",     { fg = p.comments })
  hl(0, "WinSeparator", { fg = p.border })

  -- ══ Cursor ════════════════════════════════════════════════════════
  hl(0, "CursorNormal", { bg = p.normal, fg = p.bg })
  hl(0, "CursorInsert", { bg = p.insert, fg = p.bg })
  hl(0, "CursorVisual", { bg = p.visual, fg = p.bg })
  hl(0, "Visual", { bg = p.selection })
  hl(0, "CursorLine", { bg = p.bg_line })

  -- ══ Indent guides ═════════════════════════════════════════════════
  hl(0, "IndentScope1", { fg = p.indent_scope_1, nocombine = true })
  hl(0, "IndentScope2", { fg = p.indent_scope_2, nocombine = true })
  hl(0, "IndentScope3", { fg = p.indent_scope_3, nocombine = true })
  hl(0, "IndentScope4", { fg = p.indent_scope_4, nocombine = true })
  hl(0, "IndentScope5", { fg = p.indent_scope_5, nocombine = true })
  hl(0, "MatchParen", { fg = p.visual, bold = true })
  hl(0, "IblScope",  { fg = p.visual, nocombine = true })
  hl(0, "IblIndent", { fg = p.punctuation, nocombine = true })

-- ══ Syntax ════════════════════════════════════════════════════════
  hl(0, "@variable",              { fg = p.vars })
  hl(0, "@variable.member",       { fg = p.members })
  hl(0, "@variable.parameter",    { fg = p.parameters })
  hl(0, "@property",              { fg = p.members })

  hl(0, "@function",              { fg = p.functions })
  hl(0, "@function.call",         { fg = p.functions })

  hl(0, "@keyword",               { fg = p.keywords })
  hl(0, "@keyword.return",        { fg = p.keywords })
  hl(0, "@keyword.conditional",   { fg = p.keywords })
  hl(0, "@keyword.repeat",        { fg = p.keywords })
  hl(0, "@keyword.import",        { fg = p.preproc })

  hl(0, "@type",                  { fg = p.types })
  hl(0, "@type.builtin",          { fg = p.types })

  hl(0, "@string",                { fg = p.strings })
  hl(0, "@character",             { fg = p.strings })
  hl(0, "@number",                { fg = p.numbers })
  hl(0, "@boolean",               { fg = p.boolean })
  hl(0, "@constant",              { fg = p.numbers })
  hl(0, "@constant.builtin",      { fg = p.numbers })

  hl(0, "@operator",              { fg = p.operators })
  hl(0, "@punctuation.bracket",   { fg = p.punctuation })
  hl(0, "@punctuation.delimiter", { fg = p.punctuation })

  hl(0, "@comment.documentation", { fg = p.doc_comments })

  -- ══ LSP semantic tokens ═══════════════════════════════════════════
  hl(0, "@lsp.type.macro",        { fg = p.macros })
  hl(0, "@lsp.type.type",         { fg = p.typedefs })
  hl(0, "@lsp.type.class",        { fg = p.types })
  hl(0, "@lsp.type.enum",         { fg = p.types })
  hl(0, "@lsp.type.enumMember",   { fg = p.numbers })
  hl(0, "@lsp.type.parameter",    { fg = p.parameters })
  hl(0, "@lsp.type.property",     { fg = p.members })
  hl(0, "@lsp.type.variable",     { fg = p.vars })
  hl(0, "@lsp.type.function",     { fg = p.functions })
  hl(0, "@lsp.type.method",       { fg = p.functions })
  hl(0, "@lsp.type.namespace",    { fg = p.types })
  hl(0, "@lsp.type.comment",      {})

  -- ══ Diagnostics ═══════════════════════════════════════════════════
  hl(0, "DiagnosticError", { fg = p.error })
  hl(0, "DiagnosticWarn",  { fg = p.warning })
  hl(0, "DiagnosticInfo",  { fg = p.info })
  hl(0, "DiagnosticHint",  { fg = p.hints })

  hl(0, "DiagnosticVirtualTextError", { fg = p.error })
  hl(0, "DiagnosticVirtualTextWarn",  { fg = p.warning })
  hl(0, "DiagnosticVirtualTextInfo",  { fg = p.info })
  hl(0, "DiagnosticVirtualTextHint",  { fg = p.hints })

-- ══ Telescope ═════════════════════════════════════════════════════
  hl(0, "TelescopeNormal",         { fg = p.plaintext, bg = p.panels_bg })
  hl(0, "TelescopeBorder",         { fg = p.border, bg = p.panels_bg })
  hl(0, "TelescopePromptNormal",   { fg = p.plaintext, bg = p.bg_prompt })
  hl(0, "TelescopePromptBorder",   { fg = p.border, bg = p.bg_prompt })
  hl(0, "TelescopePromptTitle",    { fg = p.keywords, bg = p.bg_prompt })
  hl(0, "TelescopePromptPrefix",   { fg = p.visual, bg = p.bg_prompt })
  hl(0, "TelescopePreviewNormal",  { fg = p.plaintext, bg = p.bg })
  hl(0, "TelescopePreviewBorder",  { fg = p.border, bg = p.bg })
  hl(0, "TelescopePreviewTitle",   { fg = p.functions, bg = p.bg })
  hl(0, "TelescopeResultsTitle",   { fg = p.types, bg = p.panels_bg })
  hl(0, "TelescopeSelection",      { bg = p.selection })
  hl(0, "TelescopeSelectionCaret", { fg = p.visual, bg = p.selection })
  hl(0, "TelescopeMatching",       { fg = p.visual, bold = true })

  -- ══ Completion (blink.cmp) ════════════════════════════════════════
  hl(0, "BlinkCmpMenu",          { fg = p.plaintext, bg = p.panels_bg })
  hl(0, "BlinkCmpMenuBorder",    { fg = p.border, bg = p.panels_bg })
  hl(0, "BlinkCmpMenuSelection", { bg = p.selection })
  hl(0, "BlinkCmpDoc",           { fg = p.plaintext, bg = p.panels_bg })
  hl(0, "BlinkCmpDocBorder",     { fg = p.border, bg = p.panels_bg })
  hl(0, "BlinkCmpLabelMatch",    { fg = p.visual, bold = true })
  hl(0, "BlinkCmpKind",          { fg = p.comments })

  -- ══ Line numbers ══════════════════════════════════════════════════
  hl(0, "LineNr",       { fg = p.line_nr })
  hl(0, "CursorLineNr", { fg = p.line_nr_active, bold = true })

  -- ══ Search ════════════════════════════════════════════════════════
  hl(0, "Search",    { bg = p.search, fg = p.bg })
  hl(0, "IncSearch", { bg = p.search_current, fg = p.bg })
  hl(0, "CurSearch", { bg = p.search_current, fg = p.bg })
  
  -- ══ nvim-tree ═════════════════════════════════════════════════════
  hl(0, "NvimTreeNormal",           { fg = p.plaintext, bg = p.bg })
  hl(0, "NvimTreeNormalNC",         { fg = p.plaintext, bg = p.bg })
  hl(0, "NvimTreeEndOfBuffer",      { fg = p.bg, bg = p.bg })
  hl(0, "NvimTreeCursorLine",       { bg = p.bg_line })
  hl(0, "NvimTreeWinSeparator",     { fg = p.border, bg = p.bg })

  hl(0, "NvimTreeRootFolder",       { fg = p.keywords, bold = true })
  hl(0, "NvimTreeFolderName",       { fg = p.types })
  hl(0, "NvimTreeOpenedFolderName", { fg = p.types, bold = true })
  hl(0, "NvimTreeEmptyFolderName",  { fg = p.comments })
  hl(0, "NvimTreeFolderIcon",       { fg = p.types })

  hl(0, "NvimTreeIndentMarker",     { fg = p.punctuation })
  hl(0, "NvimTreeOpenedFile",       { fg = p.plaintext, bold = true })
  hl(0, "NvimTreeSymlink",          { fg = p.boolean })
  hl(0, "NvimTreeExecFile",         { fg = p.functions })
  hl(0, "NvimTreeSpecialFile",      { fg = p.vars })

  hl(0, "NvimTreeLiveFilterPrefix", { fg = p.keywords, bold = true })
  hl(0, "NvimTreeLiveFilterValue",  { fg = p.plaintext })

  hl(0, "NvimTreeGitFileNewHL",     { fg = p.functions })
  hl(0, "NvimTreeGitFileDirtyHL",   { fg = p.vars })
  hl(0, "NvimTreeGitFileStagedHL",  { fg = p.boolean })
  hl(0, "NvimTreeGitFileDeletedHL", { fg = p.error })
  hl(0, "NvimTreeGitFileIgnoredHL", { fg = p.comments })
  hl(0, "NvimTreeGitFileMergeHL",   { fg = p.warning })

  hl(0, "NvimTreeDiagnosticErrorIcon", { fg = p.error })
  hl(0, "NvimTreeDiagnosticWarnIcon",  { fg = p.warning })
  hl(0, "NvimTreeDiagnosticInfoIcon",  { fg = p.info })
  hl(0, "NvimTreeDiagnosticHintIcon",  { fg = p.hints })
  hl(0, "NvimTreeGitFileNewHL",     { fg = p.functions })
  hl(0, "NvimTreeGitFileDirtyHL",   { fg = p.vars })
  hl(0, "NvimTreeGitFileStagedHL",  { fg = p.boolean })
  hl(0, "NvimTreeGitFileDeletedHL", { fg = p.error })
  hl(0, "NvimTreeGitFileIgnoredHL", { fg = p.comments })
  hl(0, "NvimTreeGitFileMergeHL",   { fg = p.warning })

  hl(0, "NvimTreeDiagnosticErrorIcon", { fg = p.error })
  hl(0, "NvimTreeDiagnosticWarnIcon",  { fg = p.warning })
  hl(0, "NvimTreeDiagnosticInfoIcon",  { fg = p.info })
  hl(0, "NvimTreeDiagnosticHintIcon",  { fg = p.hints })

  -- ══ Gitsigns ══════════════════════════════════════════════════════
  hl(0, "GitSignsAdd",    { fg = p.functions })
  hl(0, "GitSignsChange", { fg = p.vars })
  hl(0, "GitSignsDelete", { fg = p.error })
  hl(0, "GitSignsCurrentLineBlame", { fg = p.comments })

  -- ══ UI ════════════════════════════════════════════════════════════
  hl(0, "Pmenu",      { fg = p.plaintext, bg = p.panels_bg })
  hl(0, "PmenuSel",   { bg = p.selection })
  hl(0, "PmenuSbar",  { bg = p.panels_bg })
  hl(0, "PmenuThumb", { bg = p.border })

  hl(0, "SignColumn", { bg = p.bg })
  hl(0, "NonText",    { fg = p.punctuation })
  hl(0, "Whitespace", { fg = p.punctuation })
  hl(0, "SpecialKey", { fg = p.punctuation })
  hl(0, "MatchParen", { fg = p.visual, bold = true })

  hl(0, "ErrorMsg",   { fg = p.error })
  hl(0, "WarningMsg", { fg = p.warning })
  hl(0, "MoreMsg",    { fg = p.functions })
  hl(0, "Question",   { fg = p.functions })
  hl(0, "Title",      { fg = p.keywords, bold = true })

  hl(0, "Folded",     { fg = p.comments, bg = p.bg_line })
  hl(0, "FoldColumn", { fg = p.punctuation, bg = p.bg })

end

apply()
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })

return { apply = apply }


