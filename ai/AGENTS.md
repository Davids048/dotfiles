# Output format rules
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
- Ask before making any patches. If the user want an explanation, do not provide a patch right away.
- Ask for the python environment to use when running python commands. 
- Ask before running heavy processes or commands that may take a long time or require a lot of resources. e.g.
    - running a eval script
    - running a training script
    - running a compilation job
- Be explicit about assumptions you are making, compatibility adaptations, and potential risks that your proposed changes may introduce.

## HTML preview workflow

When the user asks to view, share, or validate an HTML file from the machine, prefer a temporary Cloudflare Tunnel URL over SSH port forwarding.

Use this workflow:
- Check whether `cloudflared` is available. If it is missing, install the Cloudflare Tunnel client first, using the least invasive install path that fits the machine.
- Serve the HTML file from a localhost-only static server. Use the HTML file's directory as the document root so sibling assets referenced by the page can load.
- Start a Cloudflare quick tunnel pointing at the localhost server, for example `cloudflared tunnel --url http://127.0.0.1:<port> --no-autoupdate`.
- Validate the public `trycloudflare.com` URL with an HTTP request and give that URL to the user.
- Keep the server and tunnel running if the user needs to inspect the page, and tell them the process IDs or stop command.

Before exposing local files, be explicit that a Cloudflare quick tunnel creates a public, temporary URL and anyone with the URL can access the served HTML and any served sibling assets while the tunnel is running.
