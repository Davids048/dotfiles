---
name: html-preview
description: Serve local HTML files with temporary Cloudflare quick tunnel preview URLs. Use when the user asks to view, share, open, inspect, validate, or preview HTML from the machine, and when Codex creates an HTML viewer, report, dashboard, visualization, or validation artifact that the user is likely expected to inspect in a browser.
---

# HTML Preview

## Core Rule

When the user asks to view, share, inspect, validate, or preview an HTML file from the machine, prefer a temporary Cloudflare Tunnel URL over SSH port forwarding.

Also use this workflow proactively when Codex creates an HTML viewer, report, dashboard, visualization, or validation artifact whose natural next step is browser inspection. Do not stop at only reporting a local `.html` path in that case.

## Workflow

1. Create or update the HTML artifact first. Do not skip producing the HTML just because preview serving might fail.
2. Assume `cloudflared` is available and try to use it. If it is missing or cannot run, report the local HTML path and ask for permission or setup needed to install/authenticate it.
3. Before exposing local files, state that a Cloudflare quick tunnel creates a public, temporary URL and anyone with the URL can access the served HTML and any served sibling assets while the tunnel is running.
4. Serve the HTML file from a localhost-only static server. Use the HTML file's directory as the document root so sibling assets referenced by the page can load.
5. Start a Cloudflare quick tunnel pointing at the localhost server:

```bash
cloudflared tunnel --url http://127.0.0.1:<port> --no-autoupdate
```

6. Validate the public `trycloudflare.com` URL with an HTTP request.
7. Give the validated URL to the user, along with the HTML path, process IDs, and the stop command.
8. Keep the server and tunnel running if the user needs to inspect the page.

## Failure Handling

- If `cloudflared` is missing, do not silently fall back to only a local path. Say that the HTML artifact exists, name the path, and ask for permission to install `cloudflared` using the least invasive install path that fits the machine.
- If `cloudflared` requires authentication or fails to create a quick tunnel, report the exact error summary and keep the local server state clear: either leave it running with process details if useful, or stop it and say so.
- If URL validation fails, do not claim the preview is ready. Report the local HTML path, the tunnel output, and what failed validation.
