#!/usr/bin/env sh
# Copy the voidwire design-system CSS this theme uses into the theme, and record the commit.
# voidwire is the source of truth for every colour, spacing step and part; edit there, then re-run.
set -eu
VW="${VOIDWIRE:-$HOME/development/projects/voidwire}"
DST="$(dirname "$0")/../themes/voidwire/assets/css/vw"
[ -f "$VW/tokens.css" ] || { echo "voidwire not found at $VW (set VOIDWIRE)"; exit 1; }
mkdir -p "$DST"
for f in tokens.css base.css components/helpers.css components/pill.css components/card.css \
         components/prose.css components/callout.css components/layout.css; do
  cp "$VW/$f" "$DST/$(basename "$f")"
done
cp "$VW/shapes/article/shape.css" "$DST/article.css"
git -C "$VW" rev-parse HEAD > "$DST/VOIDWIRE_REV"
echo "synced from voidwire $(cat "$DST/VOIDWIRE_REV" | cut -c1-8)"
