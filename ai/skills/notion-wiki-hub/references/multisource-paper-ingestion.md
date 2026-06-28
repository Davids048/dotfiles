# Multi-source paper/project ingestion reference

Use when David provides a paper plus related project links (arXiv, GitHub, Hugging Face model/space, project page, social/WeChat article) and asks to add it to the reading list/wiki.

## Pattern captured from Lance ingestion

1. **Deduplicate first**
   - Search Reading List by title/URL and Wiki Pages by title/arXiv ID before creating anything.
   - If a fallback/blocked-source row already exists, update it instead of creating a duplicate.

2. **Fetch canonical metadata from multiple source classes**
   - arXiv: title, authors, abstract, categories, version/date, comments, PDF, homepage/code links.
   - GitHub: repo URL, license/open-source context, description, star/fork snapshot if quickly available.
   - Hugging Face model/space: pipeline tag, task tags, model/demo descriptions, downloads/likes snapshot if quickly available.
   - Project page / social article: preserve as source links, but treat them as secondary if arXiv is canonical.

3. **Create both durable knowledge and action/reading surfaces**
   - Wiki Pages entry: durable synthesis, source links, raw abstract/evidence in a toggle, and any user-requested classification.
   - Research Reading List row: `Status = To Read`, default `Priority = Medium`, canonical paper URL, short notes, and a body link back to the wiki page.
   - Cross-link both directions.

4. **Classification tables**
   - When the user asks to classify a model definition (e.g. "unified multimodal"), put the conclusion in a top callout and a compact Notion table.
   - Distinguish marketing/task tags from actual supported I/O. If a modality is only future work, mark it unsupported and say so explicitly.

5. **Paper venue/presentation**
   - Preserve venue/presentation status when found. If not found after quick metadata lookup, write `Venue/presentation: not found; treat as arXiv preprint for now.` rather than guessing.

6. **Verification**
   - Fetch both Notion pages after updates and report both URLs.
