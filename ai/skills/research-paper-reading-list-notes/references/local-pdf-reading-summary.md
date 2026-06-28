# Local PDF Reading Summary Follow-up

Use this when David has already added a paper/repo to the Research Reading List and then asks for a reading summary from a local PDF path.

## Workflow

1. **Verify the PDF path and extract text.**
   - Check the path exists before doing Notion work.
   - Prefer a full-PDF text extraction path (`pdftotext -layout <pdf> <out.txt>` when available) so section headings, tables, and captions remain searchable.
   - Record lightweight extraction facts useful for confidence: page count, extracted text line count, title/abstract lines, and section-heading inventory.

2. **Anchor the summary to the existing Notion page.**
   - Search/fetch the existing Research Reading List page by title/canonical URL before creating anything new.
   - For GitHub/project-page entries that later provide a PDF, update the already-created page rather than making a duplicate paper row unless the user explicitly asks for a new canonical paper item.

3. **Draft the summary offline first.**
   - Write the generated summary to a temporary markdown file before updating Notion. This makes the content inspectable and gives a stable payload for a Notion update session.
   - Use the paper-reading prompt from `SKILL.md`; include section-cited evidence where the PDF has numbered sections.
   - If the paper has weak quantitative evidence or mostly qualitative comparisons, explicitly separate what is demonstrated from what is not proved.

4. **Update idempotently.**
   - Fetch the page content first.
   - Replace an existing heading `# Reading summary — <title>` or `## Reading summary — <title>` when present.
   - Append only if no matching reading-summary heading exists.
   - Preserve existing source/context sections such as `Sources`, `What it is`, `Release scope`, repository links, project-page links, and prior relationship notes.

5. **Verify after the write.**
   - Fetch the Notion page again.
   - Check the page title, summary heading, several required prompt sections, and that prior labelled sections/source context still remain.
   - If resuming after context compaction, perform a lightweight verification fetch/run before final confirmation instead of relying only on the handoff summary.

## Final response shape

Keep the user-facing completion short:

- State that the reading summary was added/updated.
- Provide the Notion URL.
- Include the verification result in one sentence: title matched, summary sections present, and existing source/context sections preserved.
