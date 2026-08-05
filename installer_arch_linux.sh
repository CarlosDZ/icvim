#!/usr/bin/env bash
#
# icVim installer — Arch Linux
#
# Installs external dependencies and links this repository as the Neovim
# configuration directory. Existing configs are backed up, never overwritten.

set -euo pipefail

readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
readonly MIN_NVIM_MAJOR=0
readonly MIN_NVIM_MINOR=12

# Required for the config to work as designed.
readonly PKGS_CORE=(
	neovim
	git
	ripgrep
	wl-clipboard
	clang
	lua-language-server
	ttf-nerd-fonts-symbols-mono
)

# Only needed for TypeScript / web work.
readonly PKGS_WEB=(
	typescript-language-server
	prettier
)

readonly SYMBOL_FONT="Symbols Nerd Font Mono"

# ── Output ──────────────────────────────────────────────────────────

if [[ -t 1 ]]; then
	readonly C_OK=$'\e[32m' C_WARN=$'\e[33m' C_ERR=$'\e[31m'
	readonly C_DIM=$'\e[2m' C_OFF=$'\e[0m'
else
	readonly C_OK='' C_WARN='' C_ERR='' C_DIM='' C_OFF=''
fi

ok()   { printf '%s  ok %s %s\n' "$C_OK"   "$C_OFF" "$1"; }
warn() { printf '%s  !! %s %s\n' "$C_WARN" "$C_OFF" "$1"; }
err()  { printf '%s  xx %s %s\n' "$C_ERR"  "$C_OFF" "$1" >&2; }
info() { printf '%s     %s%s\n'  "$C_DIM"  "$1" "$C_OFF"; }
head() { printf '\n%s\n' "$1"; }

die() { err "$1"; exit 1; }

confirm() {
	local answer
	read -rp "  $1 [y/N] " answer
	[[ "$answer" =~ ^[Yy]$ ]]
}

# ── Checks ──────────────────────────────────────────────────────────

check_arch() {
	command -v pacman >/dev/null 2>&1 \
		|| die "pacman not found. This installer targets Arch Linux."
}

check_wayland() {
	if [[ -z "${WAYLAND_DISPLAY:-}" ]]; then
		warn "Wayland session not detected"
		info "The clipboard provider is pinned to wl-clipboard in"
		info "lua/config/options.lua. On X11, swap it for xclip or xsel."
	fi
}

check_nvim_version() {
	command -v nvim >/dev/null 2>&1 || return 0

	local version major minor
	version="$(nvim --version | head -1 | grep -oP '\d+\.\d+' | head -1)"
	major="${version%%.*}"
	minor="${version##*.}"

	if (( major > MIN_NVIM_MAJOR )) \
		|| { (( major == MIN_NVIM_MAJOR )) && (( minor >= MIN_NVIM_MINOR )); }; then
		ok "neovim $version"
	else
		die "neovim $version found, but $MIN_NVIM_MAJOR.$MIN_NVIM_MINOR+ is required."
	fi
}

# ── Packages ────────────────────────────────────────────────────────

missing_packages() {
	local pkg
	for pkg in "$@"; do
		pacman -Qq "$pkg" >/dev/null 2>&1 || printf '%s\n' "$pkg"
	done
}

install_group() {
	local label="$1"; shift
	local missing
	mapfile -t missing < <(missing_packages "$@")

	if (( ${#missing[@]} == 0 )); then
		ok "$label: all present"
		return 0
	fi

	warn "$label: missing ${missing[*]}"
	if confirm "Install them with pacman?"; then
		sudo pacman -S --needed "${missing[@]}"
	else
		info "Skipped. The config will load, but those features will not work."
	fi
}

# ── Fonts ───────────────────────────────────────────────────────────

check_symbol_font() {
	if fc-list : family 2>/dev/null | grep -qi "$SYMBOL_FONT"; then
		ok "$SYMBOL_FONT installed"
	else
		warn "$SYMBOL_FONT not found"
		info "Icons will render as boxes. Install it with:"
		info "  sudo pacman -S ttf-nerd-fonts-symbols-mono"
	fi
}

kitty_notice() {
	command -v kitty >/dev/null 2>&1 || return 0

	local conf="${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf"
	if [[ -f "$conf" ]] && grep -q 'symbol_map.*U+E000' "$conf"; then
		ok "kitty symbol_map configured"
		return 0
	fi

	warn "kitty has no symbol_map for the Private Use Area"
	info "Icons will be resolved by fontconfig fallback, which picks"
	info "whatever font happens to match. Add to kitty.conf:"
	printf '\n'
	info "  symbol_map U+E000-U+F8FF,U+F0000-U+FFFFD,U+100000-U+10FFFD $SYMBOL_FONT"
	info "  symbol_map U+2190-U+21FF,U+2500-U+259F,U+25A0-U+25FF $SYMBOL_FONT"
	printf '\n'
	info "The keyboard protocol is also assumed. See the README."
}

# ── Config linking ──────────────────────────────────────────────────

backup_existing() {
	[[ -e "$NVIM_CONFIG" || -L "$NVIM_CONFIG" ]] || return 0

	if [[ -L "$NVIM_CONFIG" ]] \
		&& [[ "$(readlink -f "$NVIM_CONFIG")" == "$REPO_DIR" ]]; then
		ok "already linked to this repository"
		return 1
	fi

	local backup="${NVIM_CONFIG}.bak.$(date +%Y%m%d%H%M%S)"
	warn "existing config found at $NVIM_CONFIG"
	confirm "Move it to $backup?" || die "Aborted. Nothing was changed."
	mv "$NVIM_CONFIG" "$backup"
	ok "backed up to $backup"
}

link_config() {
	backup_existing || return 0
	mkdir -p "$(dirname "$NVIM_CONFIG")"
	ln -s "$REPO_DIR" "$NVIM_CONFIG"
	ok "linked $NVIM_CONFIG -> $REPO_DIR"
}

# ── Main ────────────────────────────────────────────────────────────

main() {
	printf '\nicVim installer\n'
	info "repository: $REPO_DIR"

	head "Environment"
	check_arch
	check_wayland

	head "Packages"
	install_group "core" "${PKGS_CORE[@]}"
	if confirm "Install TypeScript / web tooling as well?"; then
		install_group "web" "${PKGS_WEB[@]}"
	fi

	head "Fonts"
	check_symbol_font
	kitty_notice

	head "Neovim"
	check_nvim_version

	head "Configuration"
	link_config

	head "Done"
	info "Launch nvim. lazy.nvim will bootstrap and install plugins on"
	info "first start. Run :checkhealth afterwards to confirm."
	printf '\n'
}

main "$@"
