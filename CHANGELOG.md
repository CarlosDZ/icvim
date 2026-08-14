# Changelog

All notable changes to this project are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] — 2026-08-14

### Added

- **Rust support.** `rust-analyzer` configured with clippy as the check
  command and inlay hints for inferred types, `ftplugin/rust.lua` with the
  four-space indentation rustfmt expects, and highlight groups for the
  semantic tokens Rust emits — lifetimes, generics, mutable bindings and
  `unsafe`.
- **Tree-sitter parsers built from source.** `parsers.txt` declares which
  grammars this config wants; `build-parsers.sh` clones, compiles and installs
  them, copying the highlight queries into `queries/`. Parsers land outside the
  repository since they are architecture-specific binaries; queries are
  versioned.
- The installer offers to build the parsers after linking the config.

### Changed

- The package now ships `queries/`, `parsers.txt` and `build-parsers.sh`.
- `build-parsers.sh` writes queries to `~/.local/share/nvim/site/queries/` when
  the repository directory is not writable, so it works from a package install
  as well as a clone.

### Notes

Rust highlighting needs `./build-parsers.sh` to have been run at least once.
Without it, `.rs` files fall back to regex highlighting.

## [1.1.0] — 2026-08-14

First public release.

### Added

- **Completion** — blink.cmp with LSP, snippets and paths. No buffer-word
  source. Signature help fires automatically on `(` and `,`.
- **LSP** — clangd, lua_ls and ts_ls, one file per server in `lua/lsp/`.
  Format on save.
- **Navigation** — Telescope, nvim-tree with a fully explicit keymap,
  bufferline with positional numbers, gitsigns with inline blame.
- **Theme** — a dark purple scheme written by hand. `lua/icvim/palette.lua` as
  single source of truth, `:ThemeReload` to reapply without restarting,
  `check-palette.sh` to catch undefined keys.
- **Per-filetype settings** in `ftplugin/`, keeping indentation with the
  language rather than in global options.
- Every keybinding declared in `lua/config/keymaps.lua`, including the
  buffer-local ones inside the file tree.
- `installer_arch_linux.sh`, `PKGBUILD` and `cheatsheet.md`.

### Removed

- **nvim-treesitter.** Its `master` branch was archived over a year ago and
  broke on Neovim 0.12 — the highlighter threw on injections and took hover
  and signature help down with it.
- **emmet-vim.** A vimscript plugin from 2013 that fights modern `<Plug>`
  conventions.
- **nvim-cmp** and its five companion plugins, replaced by blink.cmp.
- **vim-sensible**, `nvim-ts-autotag`, and a leftover packer installation that
  had been loading twelve duplicate plugins behind lazy.nvim's back.

### Fixed

- Icons are now mapped explicitly through kitty's `symbol_map` instead of
  being resolved by fontconfig fallback, which had been picking Font Awesome
  for some glyphs and a random Nerd Font for others.
- The clipboard provider is pinned to `wl-clipboard`. Autodetection had been
  silently selecting tmux's buffer, which is not the system clipboard.

## [1.0.0]

Pre-theme. Not published.
