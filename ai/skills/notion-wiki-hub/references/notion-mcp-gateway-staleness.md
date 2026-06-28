# Notion MCP gateway staleness and fallback pattern

Use this when Notion is configured globally but a Discord/gateway session struggles to read Wiki Hub.

## Symptom pattern

- `hermes mcp list` / `hermes mcp test notion` can show Notion is enabled and connects successfully.
- A live gateway/Discord agent may still have a stale or unhealthy MCP client.
- Historical tool errors may look like:
  - `mcp_notion_notion_fetch` times out after 120s
  - `ClosedResourceError`
  - `MCP server 'notion' is unreachable after 3 consecutive failures`
  - `MCP server 'notion' is not connected`

This means the durable config/OAuth can be fine while the live agent's MCP connection is broken or wedged.

## How to explain it to David

Be precise and avoid saying “Notion tools were not exposed” if logs show `mcp_notion_*` tools existed. Better wording:

> Notion MCP was configured and the tools existed, but the gateway session's live Notion MCP connection was unhealthy/timing out; a fresh direct MCP connection worked because it bypassed that stale gateway client.

## Preferred fallback for read-only Wiki Hub inspection

1. First, try the normal exposed Notion MCP tool if it is available and healthy.
2. If it times out or the server is marked unreachable, stop retrying the same tool in a loop.
3. For simple read-only status/audit work, prefer an observable direct MCP/client script or CLI-level Notion read over an opaque nested `hermes chat` subprocess.
4. If using the direct MCP path, explain the success mode clearly: the Notion server/OAuth can still be healthy even when the gateway's long-lived MCP client is stale. A fresh `streamablehttp_client` + `ClientSession` creates a new HTTP/MCP session while reusing the stored OAuth credential, analogous to opening a new browser tab when the old tab froze.
5. If a nested Hermes fallback is necessary, bound it tightly (`--max-turns`, read-only prompt, timeout), capture its stdout/stderr, and report progress/blockers if it exceeds ~60–90 seconds.
6. After any Notion read/update, verify with a final fetch or equivalent readback before reporting success.

## User-facing style

David prefers the operational explanation in current/proposed/reasoning or cause/evidence/fix shape, not a long implementation plan. Keep it concise and own any earlier imprecise wording.