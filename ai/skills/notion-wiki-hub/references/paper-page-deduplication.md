# Paper Page Deduplication Between Wiki Hub and Research Reading List

Use this when David notices duplicate paper-note pages between Wiki Hub `Wiki Pages` and Task Hub `Research Reading List`, especially when a concept/index page links to standalone Wiki paper pages while the Reading List also contains the rich paper notes.

## Canonical-direction decision

Do not assume Wiki Hub paper pages are canonical. Ask/confirm the desired direction when duplication is present:

- **Wiki-canonical mode**: Wiki Pages hold durable notes; Reading List rows are tracking records.
- **Reading-list-canonical mode**: Research Reading List pages hold canonical paper notes because David needs to read/annotate them there; Wiki Hub concept pages act as indexes/synthesis pages that mention the Reading List pages.

If David chooses Reading-list-canonical mode, operate only on confirmed duplicate pairs unless he explicitly expands scope.

## Safe dedupe workflow

1. **Build a source-grounded mapping**
   - Match by canonical source URL / arXiv ID / DOI first, then title variants.
   - Fetch likely pairs and compare body snippets before treating them as exact duplicates.
   - Keep near-duplicates/asymmetries out of the batch unless explicitly approved.

2. **Update concept/index pages first**
   - For pages like `Image/Video Model Eval`, replace paper mentions/links from duplicate Wiki paper pages to the canonical Research Reading List pages.
   - Update wording that says “canonical wiki page/mapping” so it no longer contradicts the new direction.
   - Preserve non-paper concept pages and unrelated links. Do not remap out-of-scope papers just because a Reading List page exists.

3. **Clean Reading List backlinks**
   - On each canonical Research Reading List page, remove or replace stale `Canonical wiki page` sections that point back to duplicate Wiki pages.
   - Use a short note such as: `Canonical note: This Research Reading List page is the canonical paper note for this entry. The duplicate Wiki Hub paper page was archived during the YYYY-MM deduplication cleanup.`
   - Preserve the rich paper/eval notes in the Reading List page body.

4. **Archive, do not delete**
   - Unless David explicitly authorizes deletion/trashing, archive duplicate Wiki paper pages by setting the Wiki Pages `Status` property to `Archived`.
   - Do not move pages, set `in_trash=true`, or permanently delete during dedupe cleanup.

5. **Verify independently**
   - Fetch the concept/index page and confirm all in-scope paper links now point to the Reading List pages and no longer point to the archived Wiki duplicate pages.
   - Fetch representative Reading List pages and confirm the stale `Canonical wiki page` wording/link is gone and the canonical note is present.
   - Fetch all archived Wiki duplicate pages and confirm `Status = Archived`; they should still be readable/recoverable.

## Reporting shape

Report counts and exceptions, not a long narrative:

- concept/index pages updated
- number of Reading List pages cleaned
- number of duplicate Wiki paper pages archived
- verification pass/fail with exceptions
- explicitly state that nothing was deleted/trash-moved
