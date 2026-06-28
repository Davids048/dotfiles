# Paper report promotion into Notion Wiki Hub

Use this when a paper-summary/report was generated in chat or from a local extraction and the user asks to "update the report in Notion" or similar.

## Workflow

1. **Locate the durable page first.** Search Notion for the arXiv ID, paper title, or distinctive method name. Prefer updating an existing Wiki Pages record over creating a duplicate.
2. **Fetch the page and its parent data source.** Confirm it belongs to Wiki Pages and inspect exact property names/types before writing.
3. **Promote the report, not the scratch state.** Replace seed placeholder text with the structured research note. Keep source URL and, if useful, the local extraction path as provenance, but make the Notion page the durable source of truth.
4. **Update metadata at the same time.** For paper notes, set Type=Paper, Status=Draft or Active as appropriate, Domains=Research, Source URL=paper URL, Tags with topic/system keywords, Last Touched=today, and a concise Summary.
5. **Verify after writing.** Fetch the page again and confirm both metadata and content rendered.

## MCP property quirk observed

For Notion MCP `notion_update_page` against the Wiki Pages data source, the `Domains` multi-select property accepted a JSON-array string such as `"[\"Research\"]"`, not a raw JSON array. If a raw array raises an input-validation error, retry with the SQLite value format shown by the fetched data-source schema.

## Content shape for paper notes

- Preserve the user-requested prompt headings when the note was generated from a reading prompt.
- Add a short `Key takeaway` near the top so the page is useful before reading the full note.
- Cite sections precisely if the user requested section-level citations.
- Add an `Open questions / caveats` section for claims that are weak, proxy-based, or not fully proved.
