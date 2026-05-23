#!/bin/bash
# ─────────────────────────────────────────────────────────────
# apply_2x_exports.sh
#
# After exporting 2× PNGs from Figma, run this script to
# rename and copy them into the prototype folders.
#
# Usage:
#   bash apply_2x_exports.sh <path-to-exported-folder>
#
# The exported folder should contain files named like:
#   dreh-f1_S.png, dreh-f2_S.png, ..., dreh-f29_S.png
#   closeup-f1-1_S.png, closeup-f1-2_S.png, closeup-f1-3_S.png
#   dreh-f1_XS.png, ..., dreh-f29_XS.png          (optional)
#   closeup-f1-1_XS.png, closeup-f1-2_XS.png, closeup-f1-3_XS.png (optional)
# ─────────────────────────────────────────────────────────────

SRC="${1:?Usage: $0 <path-to-exported-folder>}"
DEST_S=~/Desktop/frames_S
DEST_XS=~/Desktop/frames
DEST_DEPLOY_S=~/Desktop/stehendanschlag-prototype-S/frames_S
DEST_DEPLOY_XS=~/Desktop/stehendanschlag-prototype/frames

echo "Source: $SRC"
echo ""

copy_if_exists() {
  local src="$1" dst_name="$2" dst_dir="$3"
  local src_path="$SRC/$src"
  if [ -f "$src_path" ]; then
    cp "$src_path" "$dst_dir/$dst_name"
    echo "  ✓ $src → $dst_name"
  fi
}

# ── _S rotation frames (29) ──────────────────────────────────
echo "_S rotation frames:"
for i in $(seq 1 29); do
  num=$(printf "%02d" $i)
  copy_if_exists "dreh-f${i}_S.png" "frame_S_${num}.png" "$DEST_S"
  copy_if_exists "dreh-f${i}_S.png" "frame_S_${num}.png" "$DEST_DEPLOY_S"
done

# ── _S closeups (3) ─────────────────────────────────────────
echo "_S closeups:"
copy_if_exists "closeup-f1-1_S.png" "closeup_S_1.png" "$DEST_S"
copy_if_exists "closeup-f1-2_S.png" "closeup_S_2.png" "$DEST_S"
copy_if_exists "closeup-f1-3_S.png" "closeup_S_3.png" "$DEST_S"
copy_if_exists "closeup-f1-1_S.png" "closeup_S_1.png" "$DEST_DEPLOY_S"
copy_if_exists "closeup-f1-2_S.png" "closeup_S_2.png" "$DEST_DEPLOY_S"
copy_if_exists "closeup-f1-3_S.png" "closeup_S_3.png" "$DEST_DEPLOY_S"

# ── _XS rotation frames (29, optional) ──────────────────────
echo "_XS rotation frames:"
for i in $(seq 1 29); do
  num=$(printf "%02d" $i)
  copy_if_exists "dreh-f${i}_XS.png" "frame_${num}.png" "$DEST_XS"
  copy_if_exists "dreh-f${i}_XS.png" "frame_${num}.png" "$DEST_DEPLOY_XS"
done

# ── _XS closeups (3, optional) ──────────────────────────────
echo "_XS closeups:"
copy_if_exists "closeup-f1-1_XS.png" "closeup_f1_1.png" "$DEST_XS"
copy_if_exists "closeup-f1-2_XS.png" "closeup_f1_2.png" "$DEST_XS"
copy_if_exists "closeup-f1-3_XS.png" "closeup_f1_3.png" "$DEST_XS"
copy_if_exists "closeup-f1-1_XS.png" "closeup_f1_1.png" "$DEST_DEPLOY_XS"
copy_if_exists "closeup-f1-2_XS.png" "closeup_f1_2.png" "$DEST_DEPLOY_XS"
copy_if_exists "closeup-f1-3_XS.png" "closeup_f1_3.png" "$DEST_DEPLOY_XS"

echo ""
echo "Done. Now re-deploy both folders to Netlify."
