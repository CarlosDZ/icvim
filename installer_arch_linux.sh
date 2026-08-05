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

# Required for the config to work at all.
readonly PKGS_CORE=(
	neovim
	git
	ripgrep
	wl-clipboard
	clang
	lua-language-server
)

# Only needed for TypeScript / web work.
readonly PKGS_WEB=(
	typescript-language-server
	prettier
)

# ── Output ──────────────────────────────────────────────────────────

if [[ -t 1 ]]; then
	readonly C_OK=$'\e[32m' C_WARN=$'\e[33m' C_ERR=$'\e[31m'
	readonly C_DIM=$'\e[2m' C_OFF=$'\e[0m'
else
	readonly C_OK='' C_WARN='' C_ERR='' C_DIM='' C_OFF=''
fi

ok()   { printf '%s  ok %s %s\n'   "$C_OK"   "$C_OFF" "$1"; }
warn() { printf '%s  !! %s %s\n'   "$C_WARN" "$C_OFF" "$1"; }
err()  { printf '%s  xx %s %s\n'   "$C_ERR"  "$C_OFF" "$1" >&2; }
info() { printf '%s     %s%s\n'    "$C_DIM"  "$1" "$C_OFF"; }
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
		info "The clipboard provider is hardcoded to wl-clipboard in"
		info "lua/config/options.lua. On X11, swap it for xclip or xsel."
	fi
}

check_nvim_version() {
	command -v nvim >/dev/null 2>&1 && return 0

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

check_nerd_font() {
	if fc-list 2>/dev/null | grep -qi 'nerd font'; then
		ok "nerd font detected"
	else
		warn "no Nerd Font detected"
		info "Icons in the file tree, tabline and statusline will render as"
		info "boxes. Install one, e.g.:"
		info "  sudo pacman -S ttf-jetbrains-mono-nerd"
	fi
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
	check_nerd_font

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
