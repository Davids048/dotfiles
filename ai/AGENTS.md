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

# Karpathy-Inspired Coding Defaults

Use these defaults when writing, reviewing, or refactoring code. They are
adapted from the `CLAUDE.md` guidance in
https://github.com/multica-ai/andrej-karpathy-skills and are meant to reduce
common coding-agent mistakes.

Tradeoff: these guidelines bias toward caution over speed. For trivial tasks,
use judgment.

## Think Before Coding

Do not assume. Do not hide confusion. Surface tradeoffs.

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them instead of silently choosing.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop, name what is confusing, and ask.

## Simplicity First

Write the minimum code that solves the problem. Add nothing speculative.

- No features beyond what was asked.
- No abstractions for single-use code.
- No flexibility or configurability that was not requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask: would a senior engineer say this is overcomplicated? If yes, simplify.

## Surgical Changes

Touch only what is necessary. Clean up only your own mess.

When editing existing code:

- Do not improve adjacent code, comments, or formatting.
- Do not refactor things that are not broken.
- Match existing style, even if you would do it differently.
- If you notice unrelated dead code, mention it instead of deleting it.

When your changes create orphans:

- Remove imports, variables, functions, or files that your change made unused.
- Do not remove pre-existing dead code unless asked.

Every changed line should trace directly to the user's request.

## Goal-Driven Execution

Define success criteria and loop until verified.

For non-trivial multi-step tasks, state a brief plan with checks:

1. `[Step]` -> verify: `[check]`
2. `[Step]` -> verify: `[check]`
3. `[Step]` -> verify: `[check]`

Strong success criteria let the agent loop independently. Weak criteria like
"make it work" require constant clarification.
