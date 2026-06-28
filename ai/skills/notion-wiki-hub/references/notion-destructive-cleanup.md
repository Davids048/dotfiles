# Notion destructive cleanup: archived duplicate paper pages

Use this reference when David explicitly approves deleting/trashing already-archived duplicate Wiki Hub pages after a paper-page deduplication pass.

## Safe sequence

1. Build an exact allowlist of page IDs and titles from the prior read-only/archival pass.
2. Before touching each page, fetch it and verify all of:
   - normalized page ID is in the allowlist,
   - parent/data source is the expected Wiki Hub `Wiki Pages` database,
   - database `Status` property is exactly `Archived`,
   - it is not a Task Hub / Research Reading List page.
3. Perform page-level deletion/trashing only after the above checks pass. Do **not** substitute another database property update for deletion.
4. Verify after the operation by fetching/searching for page-level state: success is not fetchable, or fetch shows an actual page-level trash/archive/deleted state (for example REST API `archived` / `in_trash`).
5. Stop on the first unverified deletion attempt and report the blocker rather than applying an unverified method across the batch.

## Tooling notes

- Hosted Notion MCP tool availability can vary by session/version. Check the actual discovered tools first; if page-level trash/delete is not exposed, do not assume `notion_update_page` extra arguments like `in_trash` or `archived` will have an effect just because the call is accepted.
- If hosted MCP lacks a verifiable page-level trash operation, use a real Notion integration token path instead: public Notion REST API with `NOTION_API_KEY`/`NOTION_API_TOKEN`, target pages shared with that integration, and `PATCH /v1/pages/{page_id}` with the page-level archive/trash field supported by the active Notion API version.
- The Notion MCP OAuth token is for MCP access and should not be treated as a public Notion REST API integration token. If REST returns `401 API token is invalid`, ask for/configure a proper integration token rather than retrying the MCP OAuth token.

## Reporting

Report counts and evidence, not just intent:
- number successfully trashed/deleted,
- number skipped/blocked,
- exact method used,
- verification evidence for representative/all pages,
- explicit statement that Task Hub / Research Reading List pages were untouched.
