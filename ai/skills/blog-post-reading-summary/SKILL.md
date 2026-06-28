---
name: blog-post-reading-summary
description: Use when David asks for a TL;DR, reading summary, or Notion reading-list note for a blog post, essay, tutorial, newsletter, or non-paper article. Produce a source-grounded, blog-centric draft with main theme, main argument, concepts, why it matters, and a concise takeaway.
version: 1.0.0
author: David
license: MIT
metadata:
  hermes:
    tags: [blog-posts, reading-list, summaries, notion, source-grounded-notes]
    related_skills: [productivity/notion, briefing-workflows, research-paper-reading-list-notes]
---

# Blog Post Reading Summary

## Overview

Use this workflow for non-paper reading-list items: blog posts, essays, tutorials, newsletters, technical notes, product/research-lab posts, and other articles where the user wants a readable draft for someone who has not read the source.

The output should be blog-centric rather than paper-centric. Do not force the research-paper reading prompt onto articles unless the source clearly resolves to a canonical research paper. The goal is to recover the author’s core point, organize it into a durable reading note, and add enough interpretation to make the item useful later.

## When to Use

Use this skill for requests like:

- “summarize this blog post”
- “draft a reading summary / TLDR for this article”
- “add a summary to this reading-list page”
- “what is the main theme and main argument here?”
- “write this for someone who hasn’t read the blog”
- follow-up requests after a URL was added to the Notion Research Reading List

Do not use this skill for:

- arXiv/OpenReview/proceedings papers with full technical sections — use `research-paper-reading-list-notes`.
- daily digests or multi-source briefings — use `briefing-workflows`.
- task capture only, where the user just wants a row created and no summary.

## Companion Skills

- Load `productivity/notion` before updating a Notion reading-list page.
- Load `briefing-workflows` when producing a source-grounded briefing-style output.
- Load `research-paper-reading-list-notes` only if the article resolves to a real paper and the user wants paper-style analysis.

## Workflow

1. **Fetch and ground the source.**
   - Retrieve the article title, URL, description, author/date if available, and readable body text.
   - Prefer the source page over snippets. If extraction is partial, state that limitation.
   - Ignore site chrome, comments, navigation, and unrelated recommended links.
   - For script-heavy product/blog pages, especially OpenAI/Next.js pages, retry source retrieval with browser-like headers (`User-Agent`, `Accept`, `Accept-Language`) before giving up. Then strip `<script>`/`<style>` blocks and extract the article body from stable text anchors/headings instead of summarizing page chrome.
   - For X/Twitter status URLs that contain long-form X Articles, use `references/x-article-extraction.md`: public embed/mirror endpoints such as `api.fxtwitter.com/status/<id>` can expose `tweet.article.title`, `article.id`, and `article.content.blocks[]` for grounded blog-style summaries when official tooling is unavailable.

2. **Classify the source.**
   - Determine whether it is a blog post/essay/tutorial/newsletter or a canonical research paper.
   - For blog posts, keep the summary conceptual and argument-focused. Do not invent paper-style experiments, baselines, or section references.

3. **Draft using David’s preferred organization.**
   Use this default section structure unless the user asks otherwise:

   - `# Reading summary: <title>`
   - `## TL;DR`
   - `## Main theme`
   - `## Main argument`
   - `## Why the argument matters`
   - `## Important concepts in the post`
   - `## My interpretation`
   - `## One-sentence takeaway`

4. **Write for someone who has not read the source.**
   - Start with the direct takeaway, not a chronological walkthrough.
   - Explain the author’s terms in plain language.
   - Separate the author’s claims from the assistant’s interpretation.
   - Preserve nuance: when the author frames something as speculative, exploratory, or a short note, keep that caveat.

5. **Add useful “other stuff” only when helpful.**
   Optional sections, depending on the post:
   - `## What changed my view`
   - `## Questions to revisit`
   - `## Connection to my work`
   - `## Related reading`
   - `## Caveats / what the post does not show`

6. **Update Notion when requested.**
   - Resolve the target reading-list page by the current conversation URL/title or explicit Notion URL.
   - Append a clearly titled `Reading summary` section to the child page body rather than overwriting existing metadata.
   - Keep the visible `Notes` property concise; do not paste the whole summary into Notes unless the user explicitly wants it visible on the main table.
   - Verify by fetching the page after writing.

## Style Guidelines

- Prefer concise but complete paragraphs over dense bullet dumps.
- Keep section headings stable so notes remain easy to scan across many reading-list items.
- Avoid markdown tables unless the user explicitly asks; Discord and Notion review are often better with bullets/cards.
- Use phrases like “the post argues,” “the author’s point is,” and “my read is” to distinguish source claims from interpretation.
- For technical blogs, include enough technical vocabulary to be useful later, but define it in context.

## Common Pitfalls

1. **Treating a blog like a paper.** Blog posts often do not prove claims with experiments; summarize the argument and caveats instead of inventing evidence sections.
2. **Summarizing by order instead of thesis.** A reading note should foreground the main theme, argument, and why it matters.
3. **Overclaiming.** If the author is speculative, keep the summary speculative.
4. **Burying the takeaway.** The TL;DR and one-sentence takeaway should be independently useful.
5. **Overwriting Notion content.** Append a `Reading summary` section unless the user explicitly asks for a full rewrite.
6. **Skipping verification.** Fetch the Notion page after updating and confirm the summary section is present.

## Verification Checklist

- [ ] Source URL, title, and readable body were fetched.
- [ ] Source classified as blog/article, not paper.
- [ ] Summary includes TL;DR, main theme, main argument, why it matters, concepts, interpretation, and takeaway.
- [ ] Claims are grounded in the source and not inflated beyond it.
- [ ] If Notion was updated, the target page was fetched after the write and the summary section was verified.
