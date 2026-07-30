#!/usr/bin/env bash
# Rebuild HKN graph export and publish to GitHub Pages (jk831224/hkn-mindmap).
set -euo pipefail

VAULT="${HKN_VAULT:-$HOME/hkn}"
WORK="${HKN_MINDMAP_WORK:-$HOME/.hermes/workspaces/hkn-mindmap}"
REPO_SLUG="${HKN_MINDMAP_REPO:-jk831224/hkn-mindmap}"
PAGES_URL="${HKN_MINDMAP_URL:-https://jk831224.github.io/hkn-mindmap/}"
BUILDER="$VAULT/scripts/build_hkn_graph.py"

if [[ ! -f "$BUILDER" ]]; then
  echo "ERROR: missing $BUILDER" >&2
  exit 1
fi
if [[ ! -d "$WORK/.git" ]]; then
  echo "ERROR: workspace not a git repo: $WORK" >&2
  exit 1
fi

python3 "$BUILDER" --out "$WORK/graph-data.js" --json-out "$WORK/graph.json"

cd "$WORK"
git add index.html graph-data.js graph.json README.md .nojekyll 2>/dev/null || true
git add -A

if git diff --cached --quiet; then
  echo "No changes to publish."
  echo "URL: $PAGES_URL"
  exit 0
fi

TS=$(date -Iseconds)
NODES=$(python3 -c "import json;print(json.load(open('graph.json'))['meta']['node_count'])")
EDGES=$(python3 -c "import json;print(json.load(open('graph.json'))['meta']['edge_count'])")

git -c user.email="hermes@local" -c user.name="Hermes" commit -m "chore: refresh HKN graph (${NODES}n/${EDGES}e) @ ${TS}"
git push origin HEAD:main

echo "Published to $REPO_SLUG"
echo "URL: $PAGES_URL"
echo "NOTE: Pages CDN may lag 10–60s after push."
