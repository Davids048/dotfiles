# ArXiv paper → Notion reading-list workflow

Use this reference for arXiv papers that need a full Research Reading List note.

## Retrieval pattern

1. Resolve the canonical arXiv ID from the user URL. If the user provides a direct PDF URL such as `https://arxiv.org/pdf/<id>`, normalize the primary Notion row URL to the abstract page `https://arxiv.org/abs/<id>` while still downloading the PDF for analysis.
   - If the user provides a Hugging Face Papers URL such as `https://huggingface.co/papers/<id>`, treat it as a wrapper/source page: normalize the row URL to `https://arxiv.org/abs/<id>` and preserve the HF URL in the child-page body. See `references/huggingface-paper-pages.md`.
   - If the user provides an official project page or demo site, parse it for arXiv, PDF, code, citation, and GitHub links before creating anything. Use the project page as a source link in the child-page body, but prefer the recovered canonical paper URL for the database URL property.
   - Include wrapper/project URLs in dedupe searches alongside exact title, arXiv ID, DOI/OpenReview IDs, and canonical paper URL; project or HF pages are often the user's only supplied identifier.
2. Fetch arXiv API metadata from `https://export.arxiv.org/api/query?id_list=<id>` and capture title, authors, abstract, published/updated dates, categories, comments, journal_ref, DOI, and any project-page link in the abstract/comment.
   - Persist the raw API XML/HTML and a small parsed JSON/markdown metadata file under a temp work directory before analysis. Long or single-line XML responses can be compressed/truncated in tool output; saving them prevents losing title/authors/comments/links and gives future verification a concrete artifact.
   - If the arXiv API returns empty/truncated/unusable output, fall back to `https://arxiv.org/abs/<id>` with a browser-like user agent and parse the abstract page metadata/HTML. Do not stop at the failed API call when the abstract page and PDF are still reachable.
3. Download the versioned PDF when available, e.g. `https://arxiv.org/pdf/<id>vN`, and extract text with `pdftotext -layout` or a Python PDF extractor.
   - For detailed benchmark/implementation notes, also try the arXiv source archive (`https://arxiv.org/e-print/<id>vN`). Extracted LaTeX section files often preserve tables, captions, hyperlinked section structure, and exact implementation details better than PDF text.
4. Use text search over the extracted paper/source for headings, benchmark names, table captions, ablation terms, implementation-details sections, and conclusion/limitation sections. This is faster and safer than relying on abstract-only summary.

## Venue / presentation lookup

Check, in order:

- arXiv `journal_ref`, `comments`, and DOI fields.
- OpenReview search by arXiv ID and exact title.
  - If arXiv-ID search returns noisy review/comment notes or unrelated forums, retry with the **exact title** before giving up. Exact-title search can reveal the canonical submission even when ID search is poor.
  - When a likely OpenReview submission is found, fetch the forum (`https://api2.openreview.net/notes?forum=<forum>&limit=20`) and inspect the submission plus decision notes. Prefer explicit fields/notes such as `venue`, `venueid`, `decision`, and reviewer `presentation` values. Example durable pattern: exact-title search for Transfusion found forum `SI2hI0frk6`, submission venue `ICLR 2025 Oral`, and decision note `Accept (Oral)`.
- DBLP / Semantic Scholar / proceedings pages by exact title.
  - DBLP exact-title lookup is useful even when arXiv only has a terse comment such as `ICCV2025`: it can confirm the proceedings venue, pages, DOI, and canonical DBLP key. Keep the database `Notes` property short (e.g. `ICCV 2025.`) and put DOI/pages/DBLP details in the child page body.
  - Treat OpenReview search results cautiously: exact-title or term searches can return unrelated review notes that merely cite the target paper. Verify the returned note title/forum/venue before using it as acceptance evidence.

If no venue or presentation status is found, keep the reading-list `Notes` short and status-only. For David's Research Reading List, prefer the exact concise value `arXiv preprint; no accepted venue found.` Do not infer venue status from model/project popularity, and do not put arXiv/OpenReview/DBLP lookup details in the body unless explicitly asked.

## Notion write pattern

1. Search the workspace for the exact title and arXiv ID before creating a new row.
   - When the user's starting point was a project page, also search the canonical arXiv URL, arXiv ID, and project URL. Do not create a second row just because the project-page URL differs from the paper URL.
   - Notion workspace search may return Daily Brief pages, wiki pages, or other source/context pages that merely mention the paper title/arXiv ID. Treat these as context, not duplicates, unless a fetched result is actually under the Research Reading List parent data source or has matching reading-list row properties (`Paper / Item`, canonical URL, clean `Notes`).
2. Fetch the Research Reading List database/data source if needed to get exact property names and the `collection://...` data source ID.
3. For large structured notes, prepare a self-contained write plan/prompt first: canonical metadata, dedupe keys, exact `Notes` value, source links, and the full child-page body. This prevents losing requirements during a long Notion write or delegated Hermes run.
4. Create/update a page under the data source with:
   - Title property: canonical paper title.
   - URL property: canonical arXiv abstract URL.
   - Notes property: clean accepted venue/conference/status only, or a minimal preprint/no-venue status.
   - Child-page body: full structured paper-reading note using the 9-question prompt, plus source links, relationship cues, lookup caveats, rationale, and other context unless a dedicated property exists.
5. Fetch the created/updated page to verify both visible properties and child-page body. Record a concise verification result: action taken, page URL/ID, title, URL, Notes, body markers, and duplicate-search summary.
   - After context compaction or interrupted sessions, do **not** rely only on preserved todo state. If the handoff includes a concrete created/updated Notion page ID/URL or `notion_create_pages` result, fetch that handle first and verify before doing any new write; stale `in_progress`/`pending` todos can otherwise cause duplicate paper rows.
6. If Notion MCP tools are stale in the active session but `hermes mcp test notion` succeeds, use a fresh self-contained `hermes chat -Q --source tool --max-turns <N> -s productivity/notion -s research-paper-reading-list-notes -q "$(cat /path/to/write_prompt.txt)"` subprocess for the write. For large notes, write the body to a temp markdown file and the subprocess prompt to a temp text file; include exact metadata, dedupe keys, target hub/database, clean `Notes` value, and verification requirements. Then run a second independent fresh-session verification prompt against the returned page URL/ID before reporting success.

## Analysis pattern

- Preserve section-cited `Ref: Sec.<n>` evidence for every major claim.
- Include numeric benchmark results only when recovered from paper text/tables.
- Distinguish authors' claims from your research judgment.
- Explicitly call out what is not causally proved when results mix architecture, scale, data, training stage, benchmark construction, or qualitative demos.
