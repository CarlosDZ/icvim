#!/usr/bin/env bash
# check-palette.sh — claves usadas en el tema que la paleta no define
cd "$(dirname "$0")"
comm -23 \
  <(grep -oP '\bp\.\w+' lua/icvim/theme.lua | sed 's/p\.//' | sort -u) \
  <(grep -oP '^\s*\K\w+(?= *=)' lua/icvim/palette.lua | sort -u)
