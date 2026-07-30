# HKN Mindmap (public demo)

Interactive force-directed view of Andrew's **HKN (Hermes Knowledge Nexus)** topology.

- **Live page**: https://jk831224.github.io/hkn-mindmap/
- **What is published**: node titles/paths/domains, wikilink edges, **and note markdown** for the in-page reader modal
- **What is NOT published**: personal items (`40_Personal-Items`), Templates, Log (default), raw Obsidian config

## Rebuild locally

```bash
python3 ~/hkn/scripts/build_hkn_graph.py \
  --out ~/.hermes/workspaces/hkn-mindmap/graph-data.js \
  --json-out ~/.hermes/workspaces/hkn-mindmap/graph.json
```

Then commit & push this repo (GitHub Pages serves `/docs` or root — this repo uses root `index.html`).

## Trigger (Hermes)

- `/show-your-mindmap`
- 「請給我看你現在的知識圖譜」
