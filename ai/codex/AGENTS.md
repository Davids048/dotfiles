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

# FastVideo Repository Memory System
@/home/d1su/codes/fastvideo-memory/AGENTS.md
@/home/d1su/codes/fastvideo-memory/README.md
- There is a structured memory system in place to preserve project knowledge across sessions and reduce relearning.
- Path to the memory system: /home/d1su/codes/fastvideo-memory/
- You should read the README.md and AGENTS.md files in that directory to understand how to use the memory system effectively. 
- Situations when you should consult the memory system:
    - When you start a session in FastVideo related directories. That includes:
        - folders that are git repos of the FastVideo project and its forks 
        - worktree folders of the FastVideo project and its forks
        - folders inside the fastvideo repository
        - folders that have fastvideo in their name and are related to the project
- Minimum requirement of "consult": read the README.md and AGENTS.md files in the memory system directory.
- Situations when you should write to the memory system:
    - When you have new knowledge that is not yet captured in the memory system and is worth preserving for future sessions. That includes:
        - insights about the architecture of the project
        - decisions that were made and their rationale
        - workflows that were followed or created
        - incidents that occurred and their root causes
        - domain knowledge that is relevant to the project
        - engineering practices that are useful for the project
        - others. (Discuss with the user).
- Tip: You can spawn a subagent to perform the memory reading and exploration if you want to delegate that task. Just make sure to specify the task clearly and provide the necessary context for the subagent to perform effectively.
    - Hard Rule: You must read the README.md and AGENTS.md files yourself at least once to understand the system before delegating to a subagent.



