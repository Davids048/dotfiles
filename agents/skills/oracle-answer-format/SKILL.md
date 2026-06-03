---
name: oracle-answer-format
description: Answer in Oracle's concise Answers/Evidence/Unknowns format. Use when the user says "oracle style", "oracle form", "oracle format", "answer in oracle form", or asks for Answers/Evidence/Unknowns structured answers.
---

# Oracle Answer Format

When invoked, answer the current user request in Oracle's concise, question-centered format.

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
