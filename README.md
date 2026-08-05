# icVim

A Neovim configuration built from scratch, keyboard-first and deliberately
minimal. Every plugin, keybinding and colour in here was chosen on purpose —
nothing is present by inertia.

Companion to Tundra, a Linux distribution built from source. Same philosophy:
understand every component, keep only what earns its place.

## Requirements

**Neovim 0.12+** is mandatory. This config uses the native `vim.lsp.config` API,
bundled Tree-sitter parsers, and the default LSP keymaps introduced in
0.11–0.12.

### Terminal

Designed for **kitty**. The config assumes the kitty keyboard protocol is
active, which allows distinguishing key pairs that are historically identical
in terminals:

- `<Tab>` vs `<C-i>`
- `<C-S-hjkl>` vs `<C-hjkl>`
- `<A-BS>`

In a terminal without the extended protocol those bindings will not reach
Neovim. Everything else still works.

If you use tmux, enable the protocol there too:

```tmux
set -s extended-keys on
set -g extended-keys-format csi-u
set -as terminal-features 'xterm-kitty:extkeys'
set -g escape-time 10
```

### Fonts

The theme is designed around a bitmap font (Px437 IBM VGA 8x16), with icons
mapped explicitly rather than left to fontconfig fallback. In `kitty.conf`:

```conf
font_family Px437 IBM VGA 8x16

symbol_map U+E000-U+F8FF,U+F0000-U+FFFFD,U+100000-U+10FFFD Symbols Nerd Font Mono
symbol_map U+2190-U+21FF,U+2500-U+259F,U+25A0-U+25FF Symbols Nerd Font Mono
```

Any monospace font works, but without a Nerd Font mapped to the Private Use
Area the file tree, tabline and statusline will render icons as boxes.

### External dependencies

| Binary | Purpose | Arch package |
|---|---|---|
| `clangd`, `clang-format` | C/C++ LSP and formatting | `clang` |
| `lua-language-server` | Lua LSP | `lua-language-server` |
| `typescript-language-server` | TypeScript LSP | `typescript-language-server` |
| `prettier` | Web formatting | `prettier` |
| `rg` | Telescope live grep | `ripgrep` |
| `wl-copy`, `wl-paste` | System clipboard (Wayland) | `wl-clipboard` |
| Symbols Nerd Font Mono | Icons | `ttf-nerd-fonts-symbols-mono` |

On Arch:

```sh
sudo pacman -S clang lua-language-server typescript-language-server \
               prettier ripgrep wl-clipboard ttf-nerd-fonts-symbols-mono
```

**X11 users:** the clipboard provider is pinned to `wl-clipboard` in
`lua/config/options.lua`. Replace it with `xclip` or `xsel`, or delete the
`vim.g.clipboard` block to let Neovim autodetect. It is pinned on purpose —
autodetection silently picked tmux's buffer before, which is not the system
clipboard.

## Install

Clone and link:

```sh
git clone https://github.com/CarlosDZ/icvim ~/.config/nvim
nvim
```

Or run the installer, which checks dependencies, backs up any existing config
and links this repository:

```sh
./installer_arch_linux.sh
```

Or build it as a package:

```sh
makepkg -si
```

The package installs to `/usr/share/icvim` and provides an `icvim` command that
uses `NVIM_APPNAME`, so it coexists with an existing Neovim setup instead of
replacing it.

lazy.nvim bootstraps itself on first launch and installs everything pinned in
`lazy-lock.json`.

## What's inside

### Editing

- Completion via **blink.cmp** — LSP, snippets and paths only. No buffer-word
  source, so suggestions are always semantically meaningful.
- **LuaSnip** for snippets, **nvim-autopairs** for brackets.
- Signature help fires automatically on `(` and `,`.
- Format on save through the LSP.

### Navigation

- **Telescope** for files, grep, buffers, symbols and keymaps.
- **nvim-tree** as a toggleable sidebar with a fully explicit keymap — the
  default mapping set is replaced, not extended. `<CR>` decides between opening
  in the editor and handing the file to the system, based on extension.
- **bufferline** with positional numbers matching the `<A-N>` bindings, and a
  filter that keeps system headers out of the tabline.
- **gitsigns** for hunk signs, navigation and inline blame.

### Language support

LSP servers for **C** (clangd), **Lua** (lua_ls, with the Neovim runtime
loaded) and **TypeScript** (ts_ls). One file per server in `lua/lsp/`; adding
another is a new file plus one line in `lua/lsp/init.lua`.

Syntax highlighting uses Neovim's **bundled Tree-sitter parsers** (C, Lua,
Markdown, Vim, Query). `nvim-treesitter` is deliberately absent: its `master`
branch is archived and broke on Neovim 0.12, taking hover and signature help
down with it. Web languages fall back to regex highlighting until that gets
revisited.

### Theme

A dark purple theme, defined from scratch in `lua/icvim/`. `palette.lua` is the
single source of truth; `theme.lua`, `lualine.lua` and `bufferline.lua` consume
it. `:ThemeReload` reapplies everything without restarting.

`check-palette.sh` reports palette keys used by the theme but never defined —
those fail silently as empty highlight groups, which is easy to miss.

### Design decisions worth knowing

Some behaviour here is non-standard on purpose:

- **`d`, `D`, `x`, `X` never yank.** Deleting is deleting. Cutting is
  `<leader>x`, a full operator (`<leader>xw`, `<leader>x$`, and so on).
- **`H` and `L` are line start and end**, not screen top and bottom.
- **`?` is hover documentation**, not backwards search. `K` still works.
- **Search highlight clears itself** on any key that is not `n N * # /`.
- **`:q` deletes the buffer** when its last window closes. `:W` writes and
  closes the buffer in one step.
- **Line numbers are hybrid**: relative in normal mode, absolute in insert.
- **Diagnostic jumps stop only on errors**, not warnings or hints.
- **Git status shows as filename colour** in the tree, not as icons.

## Keymaps

Leader is `Space`. Full reference in [`cheatsheet.md`](cheatsheet.md), readable
inside the editor with `<leader>ch`.

A partial view:

```
<leader>ff    Find files          <leader>e     Toggle file tree
<leader>fg    Grep contents       <A-1>..<A-0>  Go to buffer N
grd           Go to definition    <A-BS>        Close buffer
grn           Rename symbol       <Tab>         Alternate buffer
gra           Code action         [d / ]d       Prev / next error
?             Hover docs          <leader>qq    Show diagnostic
```

## Structure

```
init.lua                    Entry point, load order
lua/config/
  options.lua               Global options
  keymaps.lua               Every keybinding, plus plugin keymap tables
  autocmds.lua              Autocommands and behaviour
  commands.lua              :W and :ThemeReload
  cursor.lua                Per-mode cursor shape
  cheatsheet.lua            Cheatsheet panel toggle
lua/icvim/
  palette.lua               Colours. Single source of truth
  theme.lua                 Highlight groups
  lualine.lua               Statusline theme
  bufferline.lua            Tabline highlights
lua/lsp/
  init.lua                  Server list and shared capabilities
  clangd.lua  lua_ls.lua  ts_ls.lua
lua/plugins/
  init.lua                  Manual plugin index
  *.lua                     One file per plugin
ftplugin/
  c.lua                     Tabs, width 8, cindent
  lua.lua                   Two spaces
lazy-lock.json              Pinned plugin commits
cheatsheet.md               Keybinding reference
check-palette.sh            Palette consistency check
```

Plugin keymaps live in `lua/config/keymaps.lua` alongside everything else,
exported as tables that each plugin consumes. One file answers "what does this
key do".

## Status

Actively used, actively changing. Web language highlighting and HTML snippets
are still pending.

## License

[GNU General Public License v3.0](LICENSE)

Free to use, study, modify and redistribute. Derivative works must be
distributed under the same terms.
