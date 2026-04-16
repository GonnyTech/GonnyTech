#!/usr/bin/env bash
set -euo pipefail

TARGET_FILE="README.md"

if [[ ! -f "$TARGET_FILE" ]]; then
  echo "Target file not found: $TARGET_FILE" >&2
  exit 1
fi

TARGET_FILE="$TARGET_FILE" python3 - <<'PY'
import os
from pathlib import Path

path = Path(os.environ["TARGET_FILE"])
text = path.read_text(encoding="utf-8")

trimmed = text.rstrip(" ")

if text != trimmed:
    path.write_text(trimmed, encoding="utf-8")
else:
    path.write_text(text + " ", encoding="utf-8")
PY
