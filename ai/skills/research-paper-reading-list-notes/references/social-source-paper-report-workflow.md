# Social/source-link paper add + report workflow

Use this reference when David gives a social, WeChat, newsletter, project-page, or repo link and asks to add it to the Research Reading List, especially if the source points at a real paper.

## Pattern

1. **Resolve the wrapper source before writing Notion.**
   - Fetch/inspect the social/article page for canonical paper identifiers: arXiv ID, DOI, OpenReview/forum URL, proceedings PDF, project page, GitHub repo, title/authors.
   - If the source clearly identifies a real paper, switch to the canonical paper workflow; otherwise treat it as a non-paper reading/task item.

2. **Use the canonical paper URL as the row URL.**
   - Prefer arXiv/DOI/OpenReview/proceedings URL over the social/article URL for the database `URL` property.
   - Preserve the user-provided source link and related repo/project links in the child page body as context/source links.

3. **Keep the database `Notes` property short.**
   - Search for venue/status from arXiv metadata, OpenReview/proceedings/DBLP/search as needed.
   - If no accepted venue is found, use a minimal status such as `arXiv preprint; no accepted venue found.`
   - Do not paste venue-search evidence into `Notes` or the body unless asked.

4. **For follow-ups like “also generate the report,” “add the reading summary,” “add the summary,” or “retry,” update the existing page idempotently.**
   - Treat “reading summary” as the same 9-question section-cited paper note/report unless David specifies a shorter TL;DR.
   - Use the most recently created/resolved Research Reading List page for the source paper when the follow-up is in the same thread and unambiguous; otherwise search/deduplicate by canonical paper title/URL before asking.
   - Fetch the Notion page first and check whether a `Reading report — ...` or `Reading summary — ...` heading already exists.
   - Generate the section-cited reading report/summary from full paper text/PDF, not only metadata.
   - If a matching report/summary heading already exists, replace/update that section instead of appending a duplicate.
   - If absent, append the report/summary to the child page body.
   - Preserve database properties and existing source/context content.

5. **Verify with a live fetch after every write.**
   - Confirm exact title and canonical URL.
   - Confirm `Notes` remained clean.
   - Confirm source/context links are still present when they existed.
   - For generated reports, confirm the report heading and all expected question sections are present.

## Useful report-generation checks

- Download the PDF and extract text; inspect headings/captions/tables before drafting.
- Cite claims to real paper sections; if sections are unnumbered or extraction is imperfect, cite the exact available labels and avoid invented section numbers.
- Capture evidence nuance: benchmarks/metrics, baselines, ablations, systems measurements, and what the paper has not proved.
