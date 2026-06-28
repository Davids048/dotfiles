# Paper-note follow-up addenda

Use this when David follows up on an existing Research Reading List paper page with requests like:

- "Add a Brain dump section..."
- "Add another question section..."
- "Search again in the paper for these information, and answer faithfully"
- "What reward metric / planner / framework did they use?"
- "Add these notes/questions to the main page"

## Workflow

1. **Fetch the existing page first.** Confirm the page is the intended Research Reading List item and inspect current headings so you update in place rather than duplicating sections.
2. **Re-ground in the paper/source.** Use the paper text/PDF and, when needed, arXiv source files to search for the exact terms David asked about. Do not rely only on the previous summary already on the page.
3. **Preserve user wording for speculative/research-direction notes.** For sections like `Brain dump`, keep David's phrasing and intent visible, but clarify with paper-grounded caveats.
4. **Separate paper facts from our research hypotheses.** In follow-up Q&A sections, explicitly label what the paper says, what it does not specify, and what remains a proposed experiment for us.
5. **Use section references for factual claims.** Cite with `Ref: Sec.<n>` (or exact table/appendix if applicable). If exact values, framework names, or implementation details are absent, say so plainly.
6. **Update the page with a targeted content replacement or append.** Prefer replacing an existing matching section (`Brain dump`, `Follow-up questions`, etc.) if present; append only when absent.
7. **Fetch again after updating.** Verify the new section exists, old content was preserved, and no duplicate heading was created.

## Faithfulness patterns

- For reward/training details, list the component names exactly as the paper names them and distinguish algorithm-level descriptions from concrete software stacks.
- If the paper gives hyperparameters but not library names, write: "algorithm/framework at the method level is X; concrete software stack is not specified."
- If a model is used as a rollout/data source rather than as the deployed model, state that distinction explicitly.
- For future-work suggestions such as trying a newer backbone, verify whether the paper actually evaluated that model; if not, call it a follow-up experiment, not a paper result.

## Common pitfalls

- Do not fabricate missing implementation details such as `verl`, TRL, Ray, DeepSpeed, Accelerate, or a GitHub repo when the paper does not name them.
- Do not collapse David's speculative "we should try/build" notes into the authors' claims.
- Do not append a second copy of an existing follow-up section after a context compaction; fetch the page and replace/update if needed.
