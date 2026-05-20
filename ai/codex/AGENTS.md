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

