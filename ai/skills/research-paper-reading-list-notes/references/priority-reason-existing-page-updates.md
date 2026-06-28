# Priority/reason updates for existing paper pages

Use this when David asks to add a paper that already exists in the Research Reading List and includes short directives such as `prio: high`, `reason: ...`, or `main page: reason: ...`.

## Pattern

1. Deduplicate first by canonical paper identity. If the page already exists, update it in place rather than creating a duplicate.
2. Apply explicit database-property directives directly:
   - `prio: high` / `priority: high` -> set the `Priority` property to `High`.
   - Preserve existing `Status`, tags, and clean venue/status `Notes` unless David explicitly changes them.
3. Treat `reason`, `why`, `main page: reason`, and short research-action notes as page-body content, not `Notes` property content.
4. Add a compact section near the top or before any new reading report:

```markdown
## User reason / action note
- Priority raised to **High**.
- David's reason: **<verbatim user reason>.**
- Research angle to preserve: <1-2 sentence interpretation tied to the paper, with section refs if derived from the paper>.
```

5. If a detailed report is generated, make the user-provided reason the lens for the report rather than burying it. Example: if David says "only fine-tune planner — should work on this," explicitly track which modules are frozen vs trainable in the method/evidence sections.
6. Fetch the page after updating and verify all of these are true before final confirmation:
   - It is under the Research Reading List data source.
   - `Priority` reflects the directive.
   - The verbatim reason appears in the child page body.
   - The `Notes` property remains only venue/conference/status.

## Pitfall

Do not turn David's reason into a generic summary or rewrite it away. Preserve the exact wording somewhere visible, then add interpretation separately if useful.
