# Wiki raw-source reorganization pattern

Use this when David asks to move existing Wiki Hub pages into the Karpathy-style raw-source tier.

## Classification

- **Research Reading List**: individual papers, arXiv/PDF reading items, canonical paper notes, paper/project reading records.
- **Raw Sources**: non-paper source-of-truth material: GitHub repos, blog posts, webpages, docs, talks/videos, datasets, social posts, WeChat/articles, personal clippings.
- **Wiki Pages** should retain compiled synthesis: concepts, entities, project knowledge bases, comparisons, overviews, workflows, and maintained summaries that reference raw sources.
- **Wiki Operating Manual** is an operation/schema page, not a content tier or raw-source database.

## Write workflow

1. Confirm the move list and destination classes. If the user says “do the move,” that is approval to move exactly the listed pages and create the already-discussed Raw Sources DB if missing.
2. Prefer Notion MCP `notion-move-pages` to move existing pages/databases. Do **not** recreate pages or copy content unless explicitly asked.
3. Locate/use the existing **Research Reading List**; do not create a second one.
4. Locate/use **Raw Sources**. If absent and previously approved, create it under/near the Wiki Hub with a minimal schema:
   - `Name` title
   - `URL` url
   - `Type` select: Article, Webpage, Repo, Video, Dataset, Social, Note, Other
   - `Notes` rich text
   - `Created` created time
5. Move only the exact allowlisted page URLs/IDs.
6. Run an independent read-only verification pass after the write. Fetch the Raw Sources and Research Reading List data sources and each moved page; verify the page parent/destination matches the expected collection/data-source ID.

## Fresh-session fallback

If the current gateway/session lacks injected Notion MCP tools, use the productivity/notion fallback pattern:

```bash
hermes chat -Q --source tool --yolo --max-turns 80 \
  -s productivity/notion -s productivity/notion-wiki-hub \
  -q "$(cat /tmp/self_contained_move_prompt.txt)"
```

Then run a second **read-only** fresh-session verification prompt. If the verification run stalls on an approval/diff prompt even though it is read-only and scoped, rerun with `--yolo` and a prompt that explicitly says not to create/update/move/archive/delete/comment.

## Reporting

Keep the final answer compact:

- Created/used database URLs/IDs.
- Counts verified per destination.
- Any mismatches or failed moves.

Avoid reprinting the whole plan or lengthy reasoning after the move succeeds unless David asks for details.
