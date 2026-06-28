# Benchmark-usage follow-ups for an existing paper page

Use this reference when David asks for papers that use an existing paper's artifact/benchmark/metric/dataset/model and wants the list added back to that paper's Notion page.

## Durable pattern

1. **Anchor the target page first.** Search/fetch Notion for the canonical paper page and verify title, arXiv/DOI/PDF/repo fields before editing.
2. **Define inclusion criteria before scanning.** Count only works that explicitly use the artifact as a benchmark, evaluation metric, baseline, reward/evaluator, dataset, or experimental component. Exclude bibliography-only, related-work-only, context-only, filtering-only, and “follows the training paradigm” mentions.
3. **Search broadly, then verify by snippets.** Combine metadata search (arXiv/OpenAlex/Semantic Scholar/web) with full-text or PDF text search for the exact artifact string and aliases. Keep snippets around the match so the inclusion/exclusion decision is evidence-based.
4. **Keep a temporary candidate report.** For large candidate sets, write `/tmp/<artifact>_candidates.md` or similar with title, URL, match snippets, and an `include/exclude` judgment. Use it as the source of truth for the final Notion section.
5. **Write a clean append-only section.** Add a dated research note explaining search terms and criteria, then list confirmed papers with one sentence each explaining how the artifact is used. If useful, include a short “Near misses” subsection so future readers understand why matches were excluded.
6. **Verify after Notion write.** Fetch the page after `insert_content`/update and confirm the new section appears at the end. Do not report completion until the fetch proves it.

## Output shape for the Notion section

```markdown
## Papers using <artifact> for benchmarking

Research note added YYYY-MM-DD. I searched <sources> for `<artifact>` / `<aliases>` and kept papers that explicitly use <artifact> as <criteria>. I excluded bibliography-only/context-only mentions and papers that only <non-counted pattern>.

### Confirmed papers

- [Paper title](https://arxiv.org/abs/...) — One sentence explaining exactly how it uses the artifact.

### Near misses I did not count as benchmark use

- [Paper title](https://arxiv.org/abs/...) — Why it matched but was excluded.
```

## Pitfalls

- Do not turn this into a new reading-list item unless the user asked for a separate item. For benchmark-followup requests, update the existing paper page.
- Do not include papers solely because they cite the target paper; require explicit experimental use.
- Do not hide exclusions when many false positives exist. A concise near-miss note prevents future duplicate research.
