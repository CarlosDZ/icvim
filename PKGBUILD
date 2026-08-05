# Maintainer: CarlosDZ <snowl>

pkgname=icvim-git
_pkgname=icvim
pkgver=r1.0000000
pkgrel=1
pkgdesc="Keyboard-first Neovim configuration, built from scratch"
arch=('any')
url="https://github.com/CarlosDZ/icvim"
license=('GPL-3.0-or-later')
depends=(
	'neovim>=0.12'
	'git'
	'ripgrep'
	'wl-clipboard'
	'clang'
	'lua-language-server'
)
optdepends=(
	'typescript-language-server: TypeScript support'
	'prettier: web formatting'
	'ttf-jetbrains-mono-nerd: icons in tree, tabline and statusline'
	'xclip: clipboard on X11 (requires editing options.lua)'
)
makedepends=('git')
provides=("$_pkgname")
conflicts=("$_pkgname")
source=("$_pkgname::git+$url.git")
sha256sums=('SKIP')
install="$_pkgname.install"

pkgver() {
	cd "$srcdir/$_pkgname"
	printf "r%s.%s" \
		"$(git rev-list --count HEAD)" \
		"$(git rev-parse --short HEAD)"
}

package() {
	cd "$srcdir/$_pkgname"

	local sharedir="$pkgdir/usr/share/$_pkgname"
	install -dm755 "$sharedir"

	# Config tree. Everything the runtime needs, nothing else.
	install -Dm644 init.lua "$sharedir/init.lua"
	install -Dm644 lazy-lock.json "$sharedir/lazy-lock.json"
	install -Dm644 cheatsheet.md "$sharedir/cheatsheet.md"

	local f
	while IFS= read -r -d '' f; do
		install -Dm644 "$f" "$sharedir/$f"
	done < <(find lua ftplugin -type f -name '*.lua' -print0)

	# Launcher. Uses NVIM_APPNAME so it coexists with the user's own
	# Neovim configuration instead of replacing it.
	install -Dm755 /dev/stdin "$pkgdir/usr/bin/$_pkgname" <<-'EOF'
		#!/usr/bin/env bash
		set -euo pipefail

		readonly SHARE=/usr/share/icvim
		readonly CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/icvim"

		if [[ ! -e "$CONFIG" ]]; then
			mkdir -p "$(dirname "$CONFIG")"
			ln -s "$SHARE" "$CONFIG"
		fi

		NVIM_APPNAME=icvim exec nvim "$@"
	EOF

	install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
	install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
}
