# icVim

A Neovim configuration built from scratch, keyboard-first and deliberately
minimal. Every plugin, keybinding and option in here was chosen on purpose —
nothing is present by inertia.

Companion to [Tundra](https://github.com/CarlosDZ), a Linux distribution built
from source. Same philosophy: understand every component, keep only what earns
its place.

## Requirements

**Neovim 0.12+** is mandatory. This config uses the native `vim.lsp.config` API,
bundled Tree-sitter parsers, and default LSP keymaps introduced in 0.11–0.12.

### Terminal

Designed for **kitty**. The config assumes the kitty keyboard protocol is
active, which allows distinguishing key pairs that are historically identical
in terminals:

- `<Tab>` vs `<C-i>`
- `<C-S-hjkl>` vs `<C-hjkl>`
- `<A-BS>`

In a terminal without the extended protocol, those bindings will not reach
Neovim. Everything else works.

If you use tmux, enable the protocol there too:

```tmux
set -s extended-keys on
set -g extended-keys-format csi-u
set -as terminal-features 'xterm-kitty:extkeys'
set -g escape-time 10
```

### External dependencies

| Binary | Purpose | Arch package |
|---|---|---|
| `clangd`, `clang-format` | C/C++ LSP and formatting | `clang` |
| `lua-language-server` | Lua LSP | `lua-language-server` |
| `typescript-language-server` | TypeScript LSP | `typescript-language-server` |
| `prettier` | Web formatting | `prettier` |
| `rg` | Telescope live grep | `ripgrep` |
| `wl-copy`, `wl-paste` | System clipboard (Wayland) | `wl-clipboard` |
| A Nerd Font | Icons in tree, tabline, statusline | any |

On Arch:

```sh
sudo pacman -S clang lua-language-server typescript-language-server \
               prettier ripgrep wl-clipboard
```

**X11 users:** the clipboard provider is hardcoded to `wl-clipboard` in
`lua/config/options.lua`. Replace it with `xclip` or `xsel`, or delete the
`vim.g.clipboard` block to let Neovim autodetect.

## Install

```sh
git clone https://github.com/CarlosDZ/icvim ~/.config/nvim
nvim
```

lazy.nvim bootstraps itself on first launch and installs everything pinned in
`lazy-lock.json`. Back up your existing config first.

## What's inside

### Editing

- Completion via **blink.cmp** — LSP, snippets and paths only. No buffer-word
  source, so suggestions are always semantically meaningful.
- **LuaSnip** for snippets.
- **nvim-autopairs** for bracket pairing.
- Signature help fires automatically on `(` and `,`.
- Format on save through the LSP.

### Navigation

- **Telescope** for files, grep, buffers, symbols and keymaps.
- **nvim-tree** as a toggleable sidebar with a fully explicit keymap — the
  default mapping set is replaced, not extended.
- **bufferline** with positional numbers matching the `<A-N>` bindings, and a
  filter that keeps system headers out of the tabline.

### Language support

LSP servers configured for **C** (clangd), **Lua** (lua_ls, with the Neovim
runtime loaded) and **TypeScript** (ts_ls). Adding another is a single
`vim.lsp.config` block in `lua/plugins/lsp.lua`.

Syntax highlighting uses Neovim's **bundled Tree-sitter parsers**
(C, Lua, Markdown, Vim, Query). `nvim-treesitter` is deliberately absent: its
`master` branch is archived and broke on Neovim 0.12. Web languages fall back
to regex highlighting until that gets revisited.

### Design decisions worth knowing

Some behaviour here is non-standard on purpose:

- **`d`, `D`, `x`, `X` never yank.** Deleting is deleting. Cutting is
  `<leader>x`, which is a full operator (`<leader>xw`, `<leader>x$`, etc).
- **`H` and `L` are line start and end**, not screen top and bottom.
- **`?` is hover documentation**, not backwards search. `K` still works too.
- **Search highlight clears itself** on any key that isn't `n N * # /`.
- **`:q` deletes the buffer** when its last window closes. `:W` writes and
  closes the buffer in one step.
- **Line numbers are hybrid**: relative in normal mode, absolute in insert.

## Keymaps

Leader is `Space`. Full reference in [`cheatsheet.md`](cheatsheet.md), which is
also readable inside the editor with `<leader>ch`.

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
  highlights.lua            Indent guide colors
  cursor.lua                Per-mode cursor shape and color
  cheatsheet.lua            Cheatsheet panel toggle
lua/plugins/
  init.lua                  Manual plugin index
  *.lua                     One file per plugin
ftplugin/
  c.lua                     Tabs, width 8, cindent
  lua.lua                   2 spaces
lazy-lock.json              Pinned plugin commits
cheatsheet.md               Keybinding reference
```

Plugin keymaps live in `lua/config/keymaps.lua` alongside everything else,
exported as tables that each plugin consumes. One file answers "what does this
key do".

## Status

Actively used, actively changing. Colorscheme, git integration and icon theming
are still pending — the current look is Neovim's default.

## License

[GNU General Public License v3.0](LICENSE)

Free to use, study, modify and redistribute. Derivative works must be
distributed under the same terms.
