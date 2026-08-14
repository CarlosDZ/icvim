#!/usr/bin/env bash
#
# build-parsers.sh — compile and install Tree-sitter parsers
#
# Reads parsers.txt, builds each grammar from source and installs the
# shared object plus its highlight queries. Neovim finds parsers in any
# `parser/` directory on the runtimepath; queries live in the repo so
# they are versioned along with the rest of the config.
#
# Usage:
#   ./build-parsers.sh              build everything in parsers.txt
#   ./build-parsers.sh rust         build only rust
#   ./build-parsers.sh --force      rebuild even if already installed
#   ./build-parsers.sh --list       show what is declared and installed

set -euo pipefail

readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SPEC="$REPO_DIR/parsers.txt"

if [[ -w "$REPO_DIR" ]]; then
	readonly QUERY_DIR="$REPO_DIR/queries"
else
	readonly QUERY_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/queries"
fi

readonly PARSER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/parser"

FORCE=0
LIST=0
TARGETS=()

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

die() { err "$1"; exit 1; }

# ── Arguments ───────────────────────────────────────────────────────

parse_args() {
	local arg
	for arg in "$@"; do
		case "$arg" in
			--force|-f) FORCE=1 ;;
			--list|-l)  LIST=1 ;;
			--help|-h)
				sed -n '3,16p' "${BASH_SOURCE[0]}" | sed 's/^# \?//'
				exit 0
				;;
			-*) die "Unknown option: $arg" ;;
			*)  TARGETS+=("$arg") ;;
		esac
	done
}

# ── Spec file ───────────────────────────────────────────────────────

read_spec() {
	[[ -f "$SPEC" ]] || die "Not found: $SPEC"
	grep -vE '^\s*(#|$)' "$SPEC"
}

wanted() {
	(( ${#TARGETS[@]} == 0 )) && return 0
	local t
	for t in "${TARGETS[@]}"; do
		[[ "$t" == "$1" ]] && return 0
	done
	return 1
}

show_list() {
	printf '\n  %-12s %-10s %s\n' "LANGUAGE" "INSTALLED" "REPOSITORY"
	local lang repo _sub
	while read -r lang repo _sub; do
		if [[ -f "$PARSER_DIR/$lang.so" ]]; then
			printf '  %-12s %-10s %s\n' "$lang" "yes" "$repo"
		else
			printf '  %-12s %-10s %s\n' "$lang" "no" "$repo"
		fi
	done < <(read_spec)
	printf '\n'
}

# ── Build ───────────────────────────────────────────────────────────

check_deps() {
	command -v git >/dev/null 2>&1 || die "git not found"
	command -v cc  >/dev/null 2>&1 || die "no C compiler found"
}

build_one() {
	local lang="$1" repo="$2" subdir="${3:-}"
	local target="$PARSER_DIR/$lang.so"

	if [[ -f "$target" ]] && (( FORCE == 0 )); then
		ok "$lang already installed"
		info "use --force to rebuild"
		return 0
	fi

	local tmp
	tmp="$(mktemp -d)"
	trap 'rm -rf "$tmp"' RETURN

	info "cloning $repo"
	git clone --depth 1 --quiet "$repo" "$tmp/src" \
		|| { err "$lang: clone failed"; return 1; }

	local root="$tmp/src"
	[[ -n "$subdir" ]] && root="$tmp/src/$subdir"
	[[ -d "$root/src" ]] || { err "$lang: no src/ in $root"; return 1; }

	# scanner.c is optional; some grammars have none.
	local sources=("$root/src/parser.c")
	[[ -f "$root/src/scanner.c" ]] && sources+=("$root/src/scanner.c")

	info "compiling"
	cc -O2 -fPIC -shared -I"$root/src" "${sources[@]}" -o "$tmp/$lang.so" \
		|| { err "$lang: compilation failed"; return 1; }

	mkdir -p "$PARSER_DIR"
	install -m644 "$tmp/$lang.so" "$target"

	# Queries. Prefer the subdirectory's own, fall back to the root's.
	local qsrc="$root/queries"
	[[ -d "$qsrc" ]] || qsrc="$tmp/src/queries"

	if [[ -d "$qsrc" ]]; then
		mkdir -p "$QUERY_DIR/$lang"
		local q
		for q in highlights injections locals folds indents; do
			[[ -f "$qsrc/$q.scm" ]] \
				&& install -m644 "$qsrc/$q.scm" "$QUERY_DIR/$lang/$q.scm"
		done
	else
		warn "$lang: no queries found, highlighting will be minimal"
	fi

	ok "$lang built and installed"
}

# ── Main ────────────────────────────────────────────────────────────

main() {
	parse_args "$@"

	if (( LIST )); then
		show_list
		exit 0
	fi

	check_deps

	printf '\nBuilding Tree-sitter parsers\n'
	info "parsers: $PARSER_DIR"
	info "queries: $QUERY_DIR"
	printf '\n'

	local failed=0 count=0 lang repo subdir
	while read -r lang repo subdir; do
		wanted "$lang" || continue
		count=$((count + 1))
		build_one "$lang" "$repo" "$subdir" || failed=$((failed + 1))
	done < <(read_spec)

	(( count == 0 )) && die "Nothing matched. Try --list."

	printf '\n'
	if (( failed )); then
		err "$failed of $count failed"
		exit 1
	fi
	ok "$count parser(s) ready"
	info "add the language to the FileType autocmd in lua/config/autocmds.lua"
	printf '\n'
}

main "$@"
