# Wiki Hub status audit pitfalls

Use this reference when David asks to read/audit the current Notion Wiki Hub status.

## What went wrong in the June 2026 status audit

A request to “read the current status of the wiki hub” was handled by spawning nested `hermes chat` subprocesses with broad skills and high `max-turns`. This made the operation slow and opaque:

- A local prompt file write took about 1.4s.
- The first nested `hermes chat` read-only audit ran for ~10 minutes and timed out.
- A second nested `hermes chat --yolo` run continued for ~5.5 minutes and was interrupted by `/stop`.
- The user saw only tool breadcrumbs and asked “what are you doing?” because there was no incremental user-facing progress report.

## Durable workflow lesson

For Wiki Hub status/audit requests:

1. Prefer direct Notion MCP/tool calls in the active session when available.
2. Avoid nested `hermes chat` subprocesses for simple read-only audits unless the active session truly lacks the needed tools.
3. Do not use `--yolo` for read-only status checks; it reduces observability and can create extra local temp artifacts.
4. If a Notion call or nested subprocess runs longer than ~60–90 seconds, stop and report the blocker/progress rather than silently continuing for many minutes.
5. Keep the status report top-level and concise: current DBs/pages, obvious mismatches, and next recommended structural action only.
6. If asked for timing/accountability, use Hermes logs to report exact durations for visible tool steps rather than estimating.
