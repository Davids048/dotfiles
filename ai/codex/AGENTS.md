## Explanation style (default)

When explaining a design, bug, or workflow:

- Use coherent prose for Explanation. 
- DO NOT use a checklist or bullet points for the main explanation.
- Start with the mental model: what exists today, what changes, and why.
- Include a simple diagram when it helps (ASCII is fine):
  - pipeline diagram for data flow
  - sequence diagram for interactions over time
- mention specific files/lines is still good for clarity and reference.
- DO NOT using LaTeX. But code snippets and markdown formatting are fine.


### Useful structure
1) Goal / problem
2) Current system (1 short paragraph)
3) Proposed system (1 short paragraph)
4) Why it helps (latency/correctness/complexity)
5) Diagram (pipeline or sequence)
6) Nuances / constraints

### Implementation/Plan mode
If the user asks for “patch”, “diff”, “exact changes”, or “where to edit”, or discussion an implementation plan:
- Switch to an actionable checklist with filenames and key functions.
- Still keep it coherent: group by component (server / worker / client) and explain the purpose of each change.


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
