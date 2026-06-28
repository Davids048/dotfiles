# Wiki Pages ↔ Research Reading List Deduplication

Use this reference when David notices duplicated paper/eval-taxonomy notes between the Wiki Hub and Task Hub Research Reading List and asks for read-only investigation or cleanup planning.

## Context pattern observed

A batch can appear where:

- Wiki Hub `Wiki Pages` contains Paper pages created around one date.
- Task Hub `Research Reading List` contains matching paper rows/pages created around an adjacent date.
- Both sides share the same canonical arXiv/PDF/URL and very similar body text.
- The Research Reading List page may contain a section like `Canonical wiki page` pointing back to the Wiki Page.

That last point is important: it means the current Notion content may already encode **Wiki Page canonical → Reading List tracker**, even if David now wants **Reading List canonical → Wiki reference/index**.

## Read-only investigation workflow

1. Fetch the Wiki Hub and Task Hub to recover current data source IDs.
2. Identify:
   - Wiki Hub → `Wiki Pages`
   - Task Hub → `Research Reading List`
3. Search both data sources with a bounded date window if David provides dates.
4. Use multiple broad queries, not only exact titles:
   - `paper`, `evaluation`, `eval`, `taxonomy`, `benchmark`, `arXiv`
   - topic-specific terms like `GRPO`, `video`, `LLM`, model/benchmark names
   - exact examples David mentions, e.g. `DanceGRPO`
5. For likely matches, fetch both pages and compare:
   - title / title variants
   - canonical URL, arXiv ID, DOI, PDF URL, project URL
   - created date if visible
   - body snippets / section overlap
   - existing cross-links, especially `Canonical wiki page`
6. Return duplicates grouped as:
   - exact duplicates by canonical URL/source and content overlap
   - title-normalization duplicates
   - near duplicates / human-review items
   - asymmetries: wiki-only or reading-list-only pages

## Feasibility assessment rule

Do not assume the desired canonical direction. Report both:

- **Current encoded direction**: which page currently points to which as canonical.
- **Desired direction**: what David asked for in this session.

If David wants Research Reading List canonical and Wiki Hub as references, say it is feasible when the reading-list pages already contain the full note body and canonical URLs. Also warn that this inverts the existing structure if RRL pages currently point to Wiki Pages as canonical.

## Safe cleanup plan shape

When David later asks to actually deduplicate, prefer staged, no-loss edits:

1. Keep the canonical page's rich body content intact.
2. On the non-canonical side, preserve title, source URL, type/status metadata, and a short summary.
3. Replace duplicated long body content with a clear Notion page mention/link to the canonical page.
4. Do not delete pages in the first pass unless David explicitly confirms deletion.
5. Process 2–3 representative pairs first, verify navigation in Notion, then apply the rest of the batch.

## Reporting format

Avoid markdown tables for Discord. Use numbered lists with page URLs and evidence bullets.

For each duplicate pair, include:

- title
- Wiki Page URL
- Research Reading List URL
- canonical source URL/arXiv/PDF
- evidence: title/source/content overlap
- any current canonical/backlink direction found
