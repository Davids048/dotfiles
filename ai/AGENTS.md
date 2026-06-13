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

## Code Readability

- Add short purpose comments for dense code blocks, complex functions, and non-obvious files so readers can quickly understand intent before parsing details.
- Prefer comments that explain why a block exists or what role it plays, not line-by-line narration.
- Keep comments concise and update them when behavior changes.

## Experiment Workflow Boundary

When executing experiments, preserve a clean researcher-facing workflow.

Before creating experiment files, launching jobs, or generating run directories,
state the experiment contract:

```text
Goal: <what research question/action is being run>
Setup: <whether setup is needed, and where setup evidence will live>
Launch: <the one user-facing command or script that starts the real run>
Result: <the exact directory that will contain the real experiment output>
Class: setup | validation | real experiment | debug/internal
```

Keep artifact semantics strict:

- `runs/` is for real experiment launches only.
- Setup, environment prep, dependency checks, dry runs, generated commands,
  replay checks, debug attempts, and failed scaffolds must not be mixed into
  `runs/`.
- Put internal agent/debug artifacts under clearly named non-user-facing
  locations such as `_internal/`, `_archive/`, `validation/`, or `env_setup/`.
- Do not make "script that writes another script" the normal user-facing
  workflow unless the user explicitly asks for that indirection.
- Prefer direct researcher-facing entry points: one setup script, one launch
  script, one result directory.
- Validation is allowed, but its output should be summarized and hidden from
  the main experiment interface unless the user asks to inspect it.
- After execution, report only the clean contract: launch command,
  data/model/config sources, real run directory, logs/checkpoints/W&B links,
  and caveats.

Codex may keep an internal audit trail, but the public experiment interface
should remain: setup -> launch -> result.

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

When the user asks to view, share, or validate an HTML file from the machine, prefer a temporary Cloudflare Tunnel URL over SSH port forwarding.

Use this workflow:
- Check whether `cloudflared` is available. If it is missing, install the Cloudflare Tunnel client first, using the least invasive install path that fits the machine.
- Serve the HTML file from a localhost-only static server. Use the HTML file's directory as the document root so sibling assets referenced by the page can load.
- Start a Cloudflare quick tunnel pointing at the localhost server, for example `cloudflared tunnel --url http://127.0.0.1:<port> --no-autoupdate`.
- Validate the public `trycloudflare.com` URL with an HTTP request and give that URL to the user.
- Keep the server and tunnel running if the user needs to inspect the page, and tell them the process IDs or stop command.

Before exposing local files, be explicit that a Cloudflare quick tunnel creates a public, temporary URL and anyone with the URL can access the served HTML and any served sibling assets while the tunnel is running.
