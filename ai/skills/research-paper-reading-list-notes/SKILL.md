---
name: research-paper-reading-list-notes
description: Use when David asks to add a research paper to the Research Reading List. Create a paper-centric research note using David's section-cited paper reading prompt; do not use for blog posts, social posts, or non-paper articles unless they resolve to a real research paper.
version: 1.0.0
author: David
license: MIT
metadata:
  hermes:
    tags: [research-papers, reading-list, notion, literature-notes, paper-analysis]
    related_skills: [productivity/notion, notion-task-hub-gcal-capture]
---

# Research Paper Reading List Notes

## Overview

This is David's standing workflow for research-paper additions to the Notion Research Reading List. When the user says to add a **paper** to the reading list, do more than create a bare link row: recover the canonical paper metadata, add/deduplicate the row, and prepare a structured paper-centric research note based on the prompt below.

This skill is limited to research papers. Do **not** apply the paper-reading prompt to blog posts, news posts, social posts, GitHub repos, WeChat posts, X/RedNote posts, or general articles unless the source resolves to a canonical research paper such as arXiv, OpenReview, proceedings PDF, DOI, or official paper/project page.

## When to Use

Use this skill for requests like:

- "add this paper to my reading list"
- "add this arXiv paper"
- "put this paper in Research Reading List"
- "add the paper from this GitHub repo to reading list"
- "clean/update the Notes fields in the Research Reading List"
- "change the notes section of other entries in the reading list"
- social/WeChat/RedNote/GitHub links that clearly identify a research paper

Do not use this skill for:

- blog posts, essays, tutorials, newsletters, news articles, or product posts
- generic GitHub repositories without a linked/cited paper
- social posts where no canonical paper can be recovered
- short task additions that are not reading-list/paper items

If the source is not a paper, follow the normal reading-list or task-capture workflow without generating the research-paper note. If uncertain, say the source did not provide enough evidence that it is a research paper.

## Required Companion Skills

Before writing to Notion or the Task Hub, also load and follow:

- `productivity/notion`
- `notion-task-hub-gcal-capture` when the user phrasing is an "add task" / Task Hub capture request

## Workflow

For arXiv papers, also consult `references/arxiv-notion-workflow.md` for the proven API/PDF extraction, venue lookup, Notion data-source write, and verification pattern.

For Hugging Face Papers URLs, consult `references/huggingface-paper-pages.md` for the wrapper-source → canonical arXiv normalization, source-link preservation, and independent verification pattern.

For bulk cleanup requests over existing rows, consult `references/bulk-notes-cleanup.md` for the classification rule, context-preservation pattern, and final audit shape.

For follow-up requests asking which later papers use a paper's benchmark, metric, dataset, model, or artifact, consult `references/benchmark-usage-followups.md` for the broad-search → snippet-verify → append-and-fetch workflow.

For social/article/source links that resolve to papers, and for follow-up requests like “also generate the report,” “add the reading summary,” “add the summary,” or “retry,” consult `references/social-source-paper-report-workflow.md` for the canonical-URL, source-context preservation, idempotent report/summary update, and live-verification pattern.

For follow-up requests that provide a local PDF path and ask to add a reading summary to an already-created reading-list item, consult `references/local-pdf-reading-summary.md` for the PDF extraction → existing-page update → preservation/verification workflow.

For requests that include explicit priority and rationale directives for a paper that may already exist, e.g. `prio: high`, `reason: ...`, or `main page: reason: ...`, consult `references/priority-reason-existing-page-updates.md` for the in-place update, verbatim-reason preservation, and verification pattern.

For follow-up requests that add user research notes/questions to an existing paper page, e.g. `Add a Brain dump section`, `Add another question section`, or `search again in the paper and answer faithfully`, consult `references/paper-note-followup-addenda.md` for the fetch-first, paper-grounded, non-duplicating section-update pattern.

1. **Resolve the canonical paper first.**
   - Resolve short/social URLs and inspect the source for arXiv IDs, DOI, OpenReview/forum URLs, proceedings pages, project pages, PDF links, or citation blocks.
   - For arXiv IDs, fetch canonical arXiv metadata: title, authors, abstract, categories, published/updated dates, comments, journal_ref, DOI.
   - Actively look for venue and presentation status when available: arXiv comments/journal_ref, OpenReview, proceedings pages, Semantic Scholar/DBLP/search results. Do not guess.

2. **Deduplicate the Research Reading List row.**
   - Deduplicate by canonical title, arXiv ID, DOI, OpenReview forum, and canonical URL.
   - Treat semantically related papers as context, not duplicates, unless the canonical ID/title matches.
   - Preserve source/social/repo links in the child page body, but use the canonical paper URL as the primary row URL.
   - Keep the database `Notes` property clean: it should only state the accepted venue/conference/status (or a minimal venue-not-found/preprint status if no venue is found).
   - If an existing Wiki Hub paper page duplicates a Research Reading List page, do not automatically make the Wiki page canonical. David may prefer the Reading List page as the canonical paper-note surface. Confirm/obey the chosen canonical direction, then clean backlinks accordingly: in Reading-list-canonical mode, remove stale `Canonical wiki page` sections from the Reading List page and archive the duplicate Wiki page only after explicit approval.

3. **Create/update the visible reading-list row.**
   - Title: canonical paper title.
   - URL: canonical paper URL.
   - Notes: clean accepted venue/conference/status only, e.g. `Accepted to ICLR 2025 (Oral).` or `arXiv preprint; no accepted venue found.`
   - Put user-provided context, relationship/source links, rationale, and analysis in the child page body unless the database has a dedicated property for them.
   - Do not add venue-lookup evidence/details (for example “arXiv comments list…, DBLP lists…”) to the body unless the user explicitly asks; the concise conference/status belongs in the `Notes` property.
   - Priority/status/tags: preserve explicit user signals; otherwise use the Task Hub defaults.

4. **Generate the structured research note only when the paper text is available.**
   - Prefer the full PDF/paper text over abstract-only metadata.
   - If only abstract/metadata is available, create a metadata-only note and explicitly state that the paper did not provide enough evidence for detailed claims.
   - Never invent section numbers, claims, baselines, ablations, or results.

5. **Attach or insert the research note.**
   - Put the structured note in the child page body of the reading-list item when writing to Notion.
   - Keep the note paper-centric; do not add aggregate dashboards or generic how-to sections.
   - Use markdown formatting and each question below as a section heading.

6. **Verify.**
   - Fetch the created/updated Notion row/page after the write, especially before a final user-facing confirmation.
   - Confirm the page is under the expected Research Reading List data source, not just created as a standalone/private page.
   - Confirm the visible `Notes` property is clean and contains only accepted venue/conference/status (or minimal preprint/no-venue status).
   - Confirm relationship/source context and structured research note are in the child page body when full paper text was available.
   - If the session resumes from a context-compaction summary after the write, do one lightweight fetch of the created/updated page before finalizing rather than relying only on the summary.

7. **When the paper already exists, refresh the canonical row instead of duplicating.**
   - If dedupe search returns both a Wiki/knowledge note and a Research Reading List row for the same canonical paper, prefer the existing Research Reading List row as the reading-list surface unless David explicitly asks to canonicalize elsewhere.
   - If a section-cited `Reading report` / `Reading summary` already exists and the user asks to add the paper or provide the reading summary again, do not create a duplicate page or duplicate report section. Fetch the row, verify the existing report covers the paper, then refresh lightweight row properties that help the list view (for example `Summary`, `Last Touched`, `Domains`, or `Type`) while preserving the body content.
   - Final reply should say whether the item was created or an existing row was updated, and include the verified page URL.

## Paper Reading Prompt to Apply

When analyzing the paper, answer the following questions based on the paper.

The goal is not to summarize the whole paper, but to extract the core problem, research motivation, method, evidence, and contribution. Write in a structured, research-note style.

### Citation Rule

For every major claim, reference the source section in the paper using this format:

`Ref: Sec.<Section Number>`

Do not cite vaguely. If the paper does not provide enough evidence for a claim, explicitly say so.

### 1. What problem or challenge is this paper trying to solve?

Discuss:

- What the core problem is.
- Why this problem matters.
- What we are blocked from achieving if this problem is not solved.
- Whether this is a real bottleneck or mainly a paper-story problem constructed by the authors.

### 2. Are there previous solutions? If yes, why are they inadequate?

Discuss:

- What people used to do before this paper.
- What the bottleneck of previous methods is.
- What is inadequate, limited, or wrong in the previous solutions.
- Whether this paper is fixing the old norm or shifting to a new norm.

### 3. What related works do the authors think are necessary to understand their algorithm?

Identify:

- The main categories of related work.
- Which prior methods, systems, or theories this paper builds on.
- Which related works are directly necessary for understanding the proposed method.
- Which related works are more about positioning or comparison.

### 4. What is the proposed solution? Why might it work?

Explain:

- The core idea of the proposed method.
- The most important new abstraction or design pattern.
- Whether the paper redefines the problem in a useful way.
- The one-line thesis of the paper.
- Why the proposed solution might address the bottleneck identified earlier.

Focus on the idea that is worth remembering in a long-term research Wiki, not just implementation details.

### 5. What is the method or system lever used by the paper?

Identify which layer the paper mainly changes:

- Architecture
- Training recipe
- Data
- Inference
- Optimization
- Evaluation
- System implementation
- Hardware-aware implementation
- Other

Then discuss:

- What exact technical lever the paper uses.
- Whether this lever is transferable to other problems.
- Whether it has interfaces with MLSys, LLM optimization, JAX, TPU, Pallas, scalable RL, or other systems topics.
- Whether the method is mainly algorithmic, empirical, or systems-driven.

### 6. What has the paper proved, and what has it not proved?

Evaluate the evidence strength. Discuss:

- Whether the evidence mainly comes from benchmarks, ablations, case studies, conceptual demos, theory, or system measurements.
- Whether the experiments are solid and convincing.
- Whether the benchmark setup is fair.
- Whether the ablations actually isolate the key claims.
- Whether the author group, lab, or system implementation appears credible.
- What the paper has not proved.
- Whether the paper might be a strong result or just a clean but unstable story.

### 7. How is the solution achieved?

Explain the implementation path:

- What are the major components of the method?
- How these components interact.
- The step-by-step flow of the algorithm, system, or training pipeline.
- What parts are essential versus auxiliary.
- The key equations, modules, or procedures that enable the method.

### 8. What benchmarks, baselines, and ablations did the authors perform?

List all of the following.

#### Benchmarks

For each benchmark, include:

- Benchmark name.
- What it evaluates.
- Why it is relevant.
- Main result or conclusion.

#### Baselines

For each baseline, include:

- Baseline name.
- Why it was chosen.
- Whether it is a strong or weak baseline.
- How the proposed method compares to it.

#### Ablations

For each ablation, include:

- What component or design choice was ablated.
- What changed in the experimental setup.
- What the result showed.
- What conclusion the authors draw from the ablation.
- Whether the conclusion is fully justified.

### 9. What are the key contributions from the authors’ perspective?

List the contributions as the authors would describe them. For each contribution, explain:

- What the contribution is.
- Why the authors think it matters.
- Whether it is a conceptual, algorithmic, empirical, or systems contribution.
- Whether the contribution is genuinely new or mostly an integration of existing ideas.

## Output Rules

- Use markdown formatting.
- Use each question above as a section heading.
- Answer in structured, coherent prose.
- Use bullet points when enumerating concrete links/metadata, prior-method categories, method components, benchmarks/baselines/ablations, evidence/caveats, or user follow-up notes/questions; use prose for synthesis and judgment.
- Bullet points should be detailed and explanatory, not overly simplified.
- Do not merely restate the abstract.
- Do not hallucinate claims, numbers, or citations.
- Every major claim should reference the relevant paper section using the citation rule.
- If the paper does not provide enough evidence for a question, explicitly say so.
- If the paper’s claim is weak, overclaimed, or only partially supported, point that out.
- Focus on research judgment, not just summary.

## Common Pitfalls

1. **Applying the prompt to non-papers.** This workflow is explicitly limited to research papers. For blog posts or posts, add a normal reading-list/task item without this paper-analysis note.
2. **Using only the abstract.** The prompt requires section-level citations and evidence judgment. If full paper text is unavailable, say so and do not fabricate detailed answers.
3. **Inventing section references.** Cite `Ref: Sec.<Section Number>` only when the section exists in the paper. If a paper has named but unnumbered sections, cite the exact available section label and note the mismatch.
4. **Polluting the `Notes` property or body with venue lookup noise.** For Research Reading List papers, keep `Notes` clean: accepted venue/conference/status only, or a minimal preprint/no-venue status. Do not add venue lookup evidence/details such as “arXiv comments list…, DBLP lists…” to the child page body unless explicitly asked. Put relationship context, source links, rationale, and analysis in the page body unless a dedicated property exists.
5. **Overclaiming contribution/evidence.** Explicitly distinguish what the authors prove from what they motivate, assume, or leave untested.
6. **Duplicating report/summary sections on follow-up.** For follow-ups like “also generate the report,” “add the reading summary,” “add the summary,” or “retry,” fetch the page first and replace/update an existing `Reading report — ...` or `Reading summary — ...` section when present; append only when the matching heading is absent.
7. **Blurring user hypotheses with paper claims in follow-up addenda.** When David asks to add a `Brain dump` or follow-up question section, preserve his research-direction wording but separate it from paper-grounded facts. Re-search the paper/source for requested details, cite sections, and explicitly say when implementation frameworks, numeric weights, or model variants are not specified.
8. **Dropping wrapper-source context after canonicalization or PDF follow-up.** When a WeChat/social/repo/project page resolves to a paper, use the canonical paper URL in the row but preserve the original source link and related repo/project links in the child page body. When later adding a local-PDF reading summary to an existing page, also preserve prior labelled context sections such as `Sources`, `What it is`, and `Release scope`; do not overwrite the whole page just to insert the summary.

## Verification Checklist

- [ ] Source resolves to a real research paper.
- [ ] Canonical metadata/URL fetched where possible.
- [ ] Venue and presentation searched or caveat recorded.
- [ ] Reading-list row deduplicated and created/updated.
- [ ] Structured paper note generated only from available paper text.
- [ ] Major claims cite source sections using `Ref: Sec.<Section Number>`.
- [ ] Non-evidence or missing-evidence cases are explicitly marked.
- [ ] Notion row/page fetched after write and verified.
