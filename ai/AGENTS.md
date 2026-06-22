# Output format rules
## Local file path output

When referencing local files in responses:

- Prefer full absolute paths over bare filenames.
- Do not mention only a filename unless the parent directory is already obvious from the immediate context.

## Markdown table output

When writing Markdown tables in files:

- Prefer aligned pipe tables over compact Markdown table output.
- Pad cells so the `|` separators line up vertically across the header, separator row, and body rows.
- Keep the table separator row aligned to the same column widths as the header and body. Use `---`, `:---`, `---:`, or `:---:` as needed, then pad with spaces so the pipes still align.
- Re-check table formatting before finalizing edits, especially after changing a long header or cell value.

Example:

```markdown
| Field        | Meaning                |
| ------------ | ---------------------- |
| `CODEX_HOME` | Codex runtime home.    |
| `AGENTS.md`  | Shared agent guidance. |
```


# Working Agreements 
- If the user want an explanation, do not provide a patch right away.
- NEVER build flash-attn (Flash Attention 2) without explicit user approval. Always build flash attention with MAX_JOBS<=16.

## Cross-Worksheet Contamination

Avoid letting nearby unfinished work silently influence the current task.

Cross-worksheet contamination happens when an agent is working in one worktree,
worksheet, PR checkout, experiment area, or scratch branch, but uses a sibling
worktree, old worksheet, draft PR checkout, or uncommitted experiment as an
implementation reference without the user explicitly naming or approving it.

The issue is not that external context is always bad. The issue is that nearby
worktrees and worksheets often contain partial, rejected, experimental, or
PR-specific code, so treating them as production-ready precedent can taint the
current task.

Rules:
- Use the target worktree or worksheet, user-named sources, current
  upstream/mainline code, official docs, and local repo guidance as the default
  sources of truth.
- Do not inspect, copy, or reference sibling worktrees, old worksheets, draft PR
  checkouts, or uncommitted experiments as implementation sources unless the
  user names them or approves their use.
- If a nearby worktree looks useful, ask first: "There is a nearby worktree that
  may contain prior work on this. Do you want me to inspect it?"
- If you already used a nearby worksheet or worktree, disclose the exact path
  and treat the affected result as needing review or rework against approved
  sources.
- User-requested comparisons, audits, or provenance checks across named paths
  are allowed; keep each source's role explicit.

## Code Readability

- Add short purpose comments for dense code blocks, complex functions, and non-obvious files so readers can quickly understand intent before parsing details.
- Require every function longer than 10 lines to have a short purpose docstring instead of relying on a standalone purpose comment.
- Prefer comments that explain why a block exists or what role it plays, not line-by-line narration.
- Keep comments concise and update them when behavior changes.

## Experiment Workflow

Use the `experiment-workflow` skill before creating, modifying, validating,
debugging, or launching experiment setup, data-prep, launch scripts, run
directories, snapshots, logs, checkpoints, W&B artifacts, or other ML/research
experiment files.

Use it even when the user does not explicitly name the skill, especially for
questions about where experiment files should live or how setup, launch,
validation, debug artifacts, and real run outputs should be separated.

## Oracle Answer Format

Use this format when the user says "oracle style", "oracle form", "oracle
format", "answer in oracle form", or asks for Answers/Evidence/Unknowns
structured answers. Also use this format automatically when the current user
request contains two or more explicit questions.

When invoked, answer the current user request in Oracle's concise,
question-centered format.

If the user request mixes questions with actions, do the requested actions when
feasible instead of only confirming intent. Use the Oracle Answer Format for the
answer portions and for the final report after action has been taken.

Rules:
- Start with top-level `## Answers`.
- Provide one numbered answer per explicit caller question.
- Each numbered heading should repeat or naturally paraphrase the question.
- Under each heading, give the direct answer in 1-5 bullets or short paragraphs.
- Add top-level `## Evidence` with short path-based evidence bullets when file/config/code evidence was inspected.
- Add top-level `## Unknowns / assumptions` only when there are real unknowns or assumptions.
- Do not include broad background, long excerpts, or an implementation plan unless explicitly requested.

Template:

```markdown
## Answers

### 1. <Question paraphrase?>

- <Direct answer.>
- <Key detail if needed.>

### 2. <Question paraphrase?>

<Short paragraph answer.>

## Evidence

- `<path>`: <brief evidence>.

## Unknowns / assumptions

- <Only include if non-empty.>
```

## HTML preview workflow

Use the `html-preview` skill when the user asks to view, share, open, inspect,
validate, or preview an HTML file from the machine.

Use it proactively when Codex creates an HTML viewer, report, dashboard,
visualization, or validation artifact that the user is likely expected to
inspect in a browser. Do not stop at only reporting a local `.html` path in
that case.

If the Cloudflare preview cannot be served, still produce the HTML artifact,
report its local path, and name the install/authentication/setup blocker.
