# Bulk Research Reading List `Notes` Cleanup

Use this reference when David asks to clean or normalize the `Notes` field across existing Research Reading List entries, not just when adding a new paper.

## Goal

Normalize each row's visible `Notes` property so it contains only venue/status information, while preserving any relationship/source/context/caveat text by moving it into the page body.

## Classification Rule

Clean `Notes` examples:

- `Accepted to ICLR 2025 (Oral).`
- `Published in Transactions on Machine Learning Research (04/2025).`
- `arXiv preprint; no accepted venue found.`
- `Technical report; no peer-reviewed venue found.`
- `Blog post; no peer-reviewed venue found.`
- `Reddit thread; no peer-reviewed venue found.`
- Workshop or competition statuses such as `CODEML@ICML25.`

Dirty `Notes` examples:

- relationship/context text (`Related to ...`, `Follow-up to ...`, `Source: ...`)
- rationale (`Added because ...`, `Relevant for ...`)
- unresolved lookup caveats beyond minimal status
- copied abstracts or analysis snippets
- source/social/repo links mixed with venue/status

## Bulk Workflow

1. Fetch the Research Reading List data source schema and rows.
2. For each row, classify the current `Notes` value as clean or dirty using the rule above.
3. For dirty rows:
   - derive the minimal venue/status phrase for `Notes`;
   - preserve removed context in the page body under a short section such as `Context moved from Notes`;
   - keep source/social/repo links in the page body, not `Notes`.
4. Update the row property and page body.
5. Re-audit all inspected rows after writes and report:
   - number inspected;
   - number already clean;
   - number updated;
   - number still dirty;
   - titles requiring manual review.

## Verification Pattern

The final report should be deterministic and state zero remaining dirty notes before claiming completion. If any row is ambiguous, leave it in `manual_review` and say exactly which titles need review rather than guessing.

Do not discard information removed from `Notes`; move it into the page body first.