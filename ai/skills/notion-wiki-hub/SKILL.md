---
name: notion-wiki-hub
description: "Use when creating, updating, querying, or maintaining David's Notion Wiki Hub as the durable knowledge center, with agents as the LLM layer and local files as temporary artifacts."
version: 1.0.0
author: David
license: MIT
metadata:
  hermes:
    tags: [notion, wiki, knowledge-management, research, workflow]
    category: productivity
    related_skills: [notion, llm-wiki]
---

# Notion Wiki Hub

## Recent operational lessons

- For Wiki Hub status/audit requests, see `references/wiki-hub-status-audit-pitfalls.md`: avoid opaque nested agent subprocesses for simple read-only audits, avoid unsafe auto-approval modes for read-only checks, and report progress/blockers if a Notion read runs longer than ~60–90 seconds.
- For cases where Notion is globally configured but the Discord/gateway session times out or marks Notion unreachable, see `references/notion-mcp-gateway-staleness.md`: distinguish global MCP config from the live gateway MCP client, stop retry loops after repeated timeouts, and prefer an observable direct read path for simple read-only Wiki Hub inspection.
- For topic-discovery requests that ask what Wiki Hub pages relate to a research area, see `references/wiki-hub-topic-discovery.md`: search across Wiki Pages, Raw Sources, and the embedded Research Reading List; follow concept-page mentions; fetch candidate pages to verify relevance; then report concise page names, Notion URLs, source URLs, and one-line relevance notes.

## Overview

David's knowledge-management direction is **Notion as the durable knowledge center** and **agents as the LLM layer**. The archived local LLM Wiki app is not the active system. Local files remain useful, but only as staging areas for fast iteration: Markdown drafts, HTML visualizations, CSVs, plots, notebooks, scraped data, and coding-agent workspaces. Durable outputs should be promoted back into Notion.

This workflow intentionally starts malleable. Treat schemas and rules as high-level defaults, not hard law. Prefer changes that improve the interaction experience over preserving the initial design.

## Current Hub

- Wiki Hub: https://www.notion.so/36d51add945481c99361cc1fb1fd7d6b
- Task Hub: https://www.notion.so/36d51add94548125a191d360b13370f4

Current Wiki Hub databases:
- **Wiki Pages**: compiled wiki layer for concepts, entities, project knowledge bases, comparisons, overviews, and synthesis.
- **Raw Sources**: non-paper raw source-of-truth records such as repos, articles, webpages, docs, talks/videos, datasets, social posts, and personal clippings.
- **Source Inbox**: raw links/materials before or after processing when not yet ready for Raw Sources or a canonical reading-list item.
- **Reports & Artifacts**: temporary local files or rendered artifacts worth tracking until promoted.

Personal Hub:
- Personal Hub: https://app.notion.com/p/37851add945481d087c1f7368c82eded
- Personal Reflections: https://app.notion.com/p/38451add9454810c8994f792b9670349 — append timestamped free-form brain-dump entries here when David says “add this to my personal reflections” or similar.

Personal Reflections dictation protocol:
- Treat dictated reflections like secretary notes, not transcripts and not autobiography.
- Clean filler words, false starts, mumbling artifacts, and speech-recognition errors.
- Lightly polish and organize while preserving David’s main idea, information, wording, sequence, and intended message.
- Do not summarize away details, reinterpret, add analysis, add emotional framing, or write in the agent’s own voice.
- Keep most content unchanged unless cleanup is needed for readability.
- Use David’s local time (`America/Los_Angeles`) for new entries; format headings as `### YYYY-MM-DD HH:mm z — short title`.
- If David says “continue this section” or otherwise continues the prior reflection, append polished continuation text to the existing current entry rather than creating a new timestamped entry.
- If the reflection implies a concrete task/deadline, keep the reflection here and only create/link a Task Hub item when useful or requested.

- Use for habit building, personal operating systems, daily-life issues, personal reflections, and training logs.
- Keep it separate from Wiki Hub (work/learning knowledge) and Task Hub (concrete actions/deadlines).

## When to Use

Use this skill when the user asks to:
- add, update, reorganize, or query their wiki/knowledge base in Notion
- ingest a paper, web link, GitHub issue/PR, email, meeting note, or chat thread into durable notes
- turn a local Markdown/HTML/report artifact into a permanent Notion record
- connect Notion knowledge pages with action items in the Task Hub
- decide whether something belongs in local files, the Wiki Hub, the Source Inbox, or the Task Hub

Do not use this skill for pure task capture unless knowledge pages are involved; use the Notion task-hub pattern instead.

## Core Separation

When discussing Wiki Hub architecture, answer at the **top-level layer** first. David prefers concise structural framing over detailed implementation plans unless he asks for the plan. If he asks to understand the structure rather than get an implementation plan, keep the answer to the current structure, proposed structure, and reasoning; avoid page-by-page migration detail until asked.

Karpathy-style research wiki shape for David:

1. **Raw Sources = source-of-truth research inputs**
   - LLM reads these but should not treat them as authored wiki synthesis.
   - Use **Research Reading List** for paper / reading-item raw sources and canonical paper notes.
   - Use / create **Raw Sources** for non-paper raw material: GitHub repos, blog posts, webpages, docs, talks/videos, datasets, social posts, personal notes/clippings.
   - Some current `Wiki Pages` records may actually belong in this raw source tier; when reorganizing, classify source-like pages before treating them as wiki synthesis.

2. **Wiki Pages = compiled wiki layer**
   - LLM-maintained summaries, entity pages, concept pages, comparisons, overview, and synthesis.
   - Wiki pages should reference/link raw sources rather than replace them.
   - Good examples: `RL Training Infrastructure`, `Image/Video Model Eval`, `FastVideo Knowledge Base`.

3. **Wiki Operating Manual = operation schema**
   - Not a content tier; analogous to `AGENTS.md` / Karpathy's schema layer.
   - Defines ingest rules, query rules, lint/review rules, raw-vs-wiki boundary, naming/linking conventions, and workflow expectations.

4. **Notion Task Hub = actions**
   - deadlines, PR reviews, admin tasks, homework, reading actions

5. **Local files = temporary workbench**
   - rendered HTML visualizations, quick Markdown drafts, scraped data, plots, coding-agent scratchpads

6. **Agents = active intelligence layer**
   - search, synthesis, page updates, cross-linking, ingestion, cleanup, and schema iteration

7. **Notion Personal Hub = personal growth and life context**
   - habit-building programs, training logs, life/admin context, personal reflections, routines, self-regulation experiments
   - not a task database by default; prefer simple child pages/logs until recurring features justify schema

## Operating Workflow

### 1. Orient first

Before making significant changes, fetch the Wiki Hub and, when relevant, the involved database/page. Prefer Notion MCP tools. If a user gives only a topic, search Notion before creating a new page.

When David reports possible duplication between Wiki Hub paper pages and Task Hub Research Reading List pages, do a read-only duplicate investigation before suggesting cleanup. Compare both databases by canonical source URL/arXiv/DOI/PDF, not just exact title, and explicitly report the currently encoded canonical direction from existing backlinks. See `references/wiki-reading-list-dedupe.md` for the full workflow and safe cleanup plan shape.

### 2. Choose the destination

- **Wiki Pages** → compiled wiki/synthesis: concepts, entities, project knowledge bases, comparisons, overviews, workflows, and maintained synthesis notes.
- **Research Reading List** → paper / reading-item raw sources and canonical paper notes.
- **Raw Sources** → non-paper raw source-of-truth records: repos, articles, webpages, docs, talks/videos, datasets, social posts, and personal clippings.
- **Source Inbox** → raw link not processed yet or not yet classifiable.
- **Reports & Artifacts** → temporary HTML/Markdown/visual artifact.
- **Task Hub** → action item/deadline.
- User says they finished reading something and asks to save it → create/update a concise **Wiki Pages** note and add/update the **Research Reading List** row with `Status = Done` / already read.

### 2.5. Move misplaced raw-source pages safely

When David asks to reorganize/move Wiki Hub pages into the raw-source tier, move the existing pages; do **not** recreate them or make duplicate rows. Use **Research Reading List** for paper/read-item records and **Raw Sources** for non-paper source records. If Raw Sources does not exist and David has approved that structure, create a minimal Raw Sources database under/near the Wiki Hub, then move only the exact allowlisted pages. After moving, run a separate read-only verification pass that fetches the destination data sources and confirms each page's parent/destination. Keep the user-facing report concise: created/used databases, counts verified, mismatches/failures if any. See `references/wiki-raw-source-reorg.md` for the concrete move/verify pattern.

 from a source URL but source extraction is blocked by consent, paywall, CAPTCHA, or unavailable fetches, still leave a durable trace instead of ending with no Notion change: create or update a minimal **Source Inbox** item or **Wiki Pages** seed page with the URL, an honest placeholder title, `Status = Needs Review` or `Seed`, and a short limitation note. Only ask for follow-up text/consent after preserving the source, unless the requested update would be misleading without content.

For short user notes like “look into <person>'s work” or “<person/org> is a good example of <theme>,” create or update a `Person / Org` or `Concept` seed page in **Wiki Pages** rather than only adding a task. Preserve the user's exact research rationale near the top, set `Domains` to `Research` when appropriate, and link current related reading-list/wiki pages as anchor papers/sources so the note is immediately navigable.

When the user adds follow-up facts about a person/org page (e.g. personal website, affiliation, collaborators, or an extra research direction), update the existing seed page rather than creating a new item. Search/fetch the current page, add the canonical personal website to `Source URL` or the sources section, update `Summary`/`Tags` with the new durable themes, append a short “Update” section if the body lacks a place for it, and verify with a final fetch. If a personal website is requested but no URL is supplied, do a quick public lookup and prefer the person's own homepage over third-party profiles.

For quick “add to reading list” requests, use the existing **Research Reading List** database in the Task Hub. Search/fetch the database schema first if its data source ID or property names are not already known, search for the exact URL or title to avoid duplicates, then create the row with `Status = To Read`, default `Priority = Medium` unless the user says high/low, and preserve the source URL in `URL`. If metadata fetching is blocked (for example, a WeChat captcha), do not stall or invent a title: use a clear fallback title based on the source/URL slug, add a short note that the title could not be fetched automatically, and verify the created row with a final fetch. If the user also asks to link the new reading-list item to a named Wiki page, search for that exact Wiki page before linking; if no exact page exists, create a concise seed page with the requested title and link the reading-list item there rather than silently substituting a broader near-match. A near-match such as an index page can be added as adjacent context, but the user's explicitly named page should exist after the operation unless they explicitly asked not to create pages. Verify both pages after writing and confirm the cross-link text/mentions are present. If the user later says “try again” and provides related links (arXiv PDF, project page, GitHub, etc.), update the existing fallback row rather than creating a duplicate: fetch metadata from the related sources, rename the item to the identified paper/project title, keep the original blocked URL in `URL`, add the related links in the page body, and note any corrected canonical URL (for example, a short project URL redirect/404 versus the working project page).

For paper/project ingestion where the user supplies multiple related sources (arXiv + GitHub + Hugging Face + project page + social/WeChat), create or update both the **Research Reading List** row and a durable **Wiki Pages** paper/project note unless the user explicitly asks for only one surface. Cross-link them in both directions. Fetch canonical metadata from the arXiv paper first, then enrich from GitHub/Hugging Face/project pages. Put user-requested classifications (for example, model I/O modality support) in a top callout plus a compact Notion table, and clearly separate actual current support from future-work claims or marketing tags. When adding an implementation/source repo to an existing paper page, preserve it as an objective `Sources` / `Related links` item in the page body; do not change the Research Reading List `Notes` property unless the link changes accepted venue/status. Record venue/presentation when found; if not found after quick lookup, say it is not found / arXiv preprint for now rather than guessing. See `references/multisource-paper-ingestion.md`.

When the user asks to create a broader wiki item from a newly added paper or cluster (for example “add a new wiki named something like Image/Video Model Eval; add this paper as related”), treat it as a **concept bridge page** in Wiki Pages. Search first for exact/near concept titles to avoid duplicates, then create/update a `Concept` page with `Status = Seed` or `Draft`. Keep objective organizing pages compact: `Summary`, `Scope`, and `Related papers / anchors`. Do **not** add subjective/forward-looking sections such as `Open questions` unless the user explicitly asks for them. Add the triggering paper with both its Notion reading-list/wiki page and canonical external source link, include one sentence explaining why it belongs, and add a few adjacent existing wiki anchors if they were found during search. For the Notion paper link, use an actual Notion page mention/backpage (for example `<mention-page ...>`) rather than only a raw URL/markdown link; Research Reading List pages are valid backpages/mentions on Wiki Pages. If safe, add a concise backlink from the paper page to the concept page. Verify the concept page links, page mention/backpage behavior, and backlink with a final fetch before reporting success.

### 3. Keep pages readable

Use a small set of sections and avoid over-structuring early. For objective information-organizing tasks, do not add subjective or forward-looking sections such as `Open questions`, `Next steps`, or recommendations unless the user explicitly asks for them. For longer Notion page edits, insert divider/separator lines (`---`) between major sections when it improves scanning; David specifically prefers occasional separators for better viewing. Good starting sections when appropriate:
- Summary
- Why I saved it / why it matters to the user
- Sources
- Key points
- Related pages / tasks

When the user gives a short rationale like “not central to my focus, but interesting because…”, preserve that rationale in the page body and in any related reading-list notes. This user-context is often more useful later than a generic article summary.

When the user says “in my wiki I want to add this reflection” and provides a checklist-like note rather than a source URL, create or update a **Workflow** or **Note** page in Wiki Pages. Search first for an obvious existing page; if none exists, create a focused page with the user's reflection as a top callout, then organize the raw points into a practical checklist/template. For workflow reflections, include an explicit reusable prompt/template section and an output contract when the user mentions outputs, tables, configs, failures, environment, compute, or git/worktree details. Keep the page Draft unless the user says it is an established workflow. Verify by fetching the created/updated page before reporting the Notion URL.

For project/reflection updates driven by social posts or external amplification (X/Twitter, LinkedIn, company blogs, etc.), prefer updating the existing project knowledge page rather than creating a standalone source note when the user frames it as “my reflection on <project/release>.” Preserve the user's interpretation as first-class content, not just the fetched post text: why the post matters, what story/frame it reveals, audience/reply signals, and concrete follow-up ideas. Fetch enough public metadata/snippets to ground the URLs when possible, but do not over-focus on engagement counts if they are unavailable; the durable value is the user's reflection plus source links.

### 4. Preserve provenance lightly

Always keep source URLs when available. Do not build a heavy citation system unless the user asks or repeated usage shows it is needed.

When the user asks to add “related readings” or source links from the current chat/research thread to an existing Notion page/section, treat it as a scoped page update rather than a new wiki item. Use the provided Notion URL, including any `#block-id` anchor, to infer the target section; fetch the page first, deduplicate against existing related-reading/source sections, and add a compact heading plus bullets with title, source links, and one sentence explaining why each reading is relevant. If Notion fetch/update tools do not expose exact block IDs, do not overfit to the URL fragment: insert near the nearest visible heading/section that matches the anchor context, or append at the end with a clear section label, then verify by fetching the page and checking both content and placement. No markdown tables.

When the user says “add these as a raw source” / “add these as raw source” or otherwise refers to a cluster of links/results from the current chat/thread, default to **one aggregate Raw Sources row** for the whole thread/source cluster unless the user explicitly asks for one row per link. Resolve “these” from the visible conversation/thread before asking, collect and deduplicate concrete source URLs from prior messages and embeds, and put the URL list in the aggregate page body. Use the originating chat/thread URL as `Source URL` when the cluster itself is the source; use `Type = Note` or `Webpage`, `Domains = Research`, `Status = Seed`, and preserve a compact capture note. Only create separate rows per source when the user clearly says each item should be independently tracked. Verify the created/updated aggregate row by fetching it after the write.

For a **single social/link raw-source capture** such as “add this as a raw source,” still do a lightweight metadata pass before writing when it is cheap and safe. Preserve the user’s own classification/rationale in both properties and page body. For Reddit shortlinks specifically, direct `reddit.com` fetches may only return a verification page and `.json` may be blocked; try `old.reddit.com` with the resolved `/comments/<id>/<slug>/` URL to recover the post title. If Notion `query_data_sources` is unavailable because the workspace lacks Enterprise/Notion AI, use scoped `notion_search` on the Raw Sources data source for duplicate checks rather than stalling or assuming no duplicate. Then create a minimal Raw Sources row with `Type = Social`, `Status = Seed`, `Domains = Research`, source shortlink, resolved URL when found, retrieved title/metadata, and the user’s contextual note.

### 5. Promote local artifacts

When a local artifact becomes useful:
1. summarize the useful conclusion in a Wiki Page
2. link or record the artifact in Reports & Artifacts only if it may be useful again
3. avoid treating the local file as source of truth after promotion

For paper-reading reports, update the existing paper page rather than creating a new report page when a seed page already exists. Search by arXiv ID/title, fetch the page and data-source schema, replace seed content with the structured note, update metadata, and verify with a final fetch. See `references/paper-report-promotion.md`.

For duplicate paper-note cleanup between Wiki Hub `Wiki Pages` and Task Hub `Research Reading List`, do **not** assume the Wiki page is canonical. David may want Research Reading List pages to be the canonical paper-note surface because that is where he tracks reading/annotations, while Wiki Hub concept pages act as indexes/synthesis pages. In reading-list-canonical cleanup, build exact duplicate mappings by source URL/arXiv ID, update concept/index pages to mention the Research Reading List pages, remove stale `Canonical wiki page` backlinks from the Reading List pages, and archive duplicate standalone Wiki paper pages by setting `Status = Archived` only. Never delete/trash/move duplicate Wiki pages without explicit permission. If David later explicitly approves deleting the archived duplicates, use an exact allowlist, verify each page is still `Status = Archived` in Wiki Pages before touching it, perform only a verifiable page-level trash/delete operation, and stop on the first unverified tool path rather than treating a database status/property update as deletion. See `references/paper-page-deduplication.md` and `references/notion-destructive-cleanup.md`.

### 6. Iterate schema gently

If the current schema is awkward, change it. Add properties/views/databases only when the user experience demands it. Do not enforce rigid taxonomy at the start.

### 7. Convert long Notion sections into database tables when asked

When the user asks to “turn this section/list into a database table,” treat the existing page content as source data and preserve the surrounding note rather than rebuilding the whole page:
1. Fetch the page and identify the exact section Markdown to replace.
2. Create a child database under the page with a title property plus a few task-specific properties (for paper lists, useful columns are title, category/status, source URL/ID, type/classification, and a concise notes/use-summary field).
3. Set the data source `is_inline=true` so the table appears in the page body, not only as a linked database page.
4. Populate rows from the existing bullets; split combined “near miss” bullets into separate rows when separate entries are more useful for filtering/search.
5. Replace the old long bullet section with a short provenance note pointing to the inline database. If the exact Markdown replacement fails, re-fetch/compare the rendered Notion Markdown and retry with the exact line/link formatting Notion returns.
6. Verify both the page embed (`<database ... inline="true">`) and at least a couple of representative rows via fetch/search before reporting success.

### 8. Personal Hub for habit/life training logs

When David asks to create or organize a personal hub for habits, daily-life issues, procrastination training, routines, or personal reflections, use the **Personal Hub** rather than Wiki Hub or Task Hub. Start with lightweight child pages/log pages, not databases, unless the user explicitly asks for a schema. This is especially important for habit-training programs where the useful properties are not known yet.

Good initial Personal Hub structure:
- **Training Logs** — dated child pages or entries for fog logs, de-fuzzing sessions, start reps, avoidance-rescue sessions, evening reviews, and weekly pattern reviews.
- **Protocols / Templates** — reusable scripts such as Fog Log, De-fuzzing, Start Rep, Avoidance Rescue, Weekly Review, and Next-Start Note.
- **Personal Patterns** — synthesized triggers, common fog types, escape behaviors, interventions that work/don't work, and personal rules discovered after enough logs.
- **Daily Life / Admin** — context and reflections around life issues; concrete obligations still belong in Task Hub.
- **Habit Building** — sleep, exercise, focus, phone/video/game use, routines, energy management, and self-regulation experiments.

For habit/procrastination training programs with daily reminders, use this lightweight loop:
1. Create or update one central Personal Hub program page (for David's current procrastination program: `30-Day Procrastination Training Program`) rather than scattering tiny daily child pages.
2. Include the reusable command list on the page so future agents can discover the interaction contract: `Hermes, fog log.`, `Hermes, de-fuzz this.`, `Hermes, run a start rep.`, `Hermes, I’m entering avoidance.`, and `Hermes, weekly pattern review.`
3. If the user wants reminders, create an agent/automation reminder that sends the command list and asks the user to reply with one command plus a short task description. The reminder should remind, not claim to have updated Notion.
4. After each actual interactive training session, append the dated log to the central page's **Training Logs** section; append weekly syntheses to **Weekly Reviews**. Do not create a database or dashboard unless several weeks of logs reveal a real need.
5. Add an explicit "Agent update protocol" section to the Notion page telling future agents to append logs to that same page after sessions.

Organization principle: begin with simple dated log entries and only convert to databases after several weeks of data reveal useful features/relations. Avoid building dashboards or rigid schemas up front; the user's explicit preference is to document sessions first and discover the structure later.

## Default Page Types

Use the existing `Type` values when possible:
- Paper
- Concept
- Project
- Source
- Report
- Person / Org
- Meeting
- Workflow
- Note

Use `Status` loosely:
- Seed: placeholder or first-pass note
- Draft: useful but incomplete
- Active: maintained and trusted enough to use
- Needs Review: uncertain, stale, or conflict-prone
- Archived: preserved but no longer active

## Common Pitfalls

1. **Creating duplicates.** Search/fetch first when topic names are obvious. For paper pages, deduplicate by canonical URL/arXiv/DOI/PDF as well as normalized title; title variants like short benchmark names versus full paper titles can still be exact duplicates.
2. **Assuming canonical direction from database location.** If the same paper exists in Wiki Pages and Research Reading List, inspect backlinks/body text before recommending cleanup. The current pages may say `Canonical wiki page` even when David wants Reading List pages to become canonical.
3. **Over-designing early.** The user explicitly wants malleable guidelines, not fixed rules.
3. **Letting local files become permanent truth.** Promote the insight into Notion.
4. **Mixing tasks into the wiki.** Create/link Task Hub items for actions.
5. **Forgetting source URLs.** Lightweight provenance is still important.
6. **Assuming the old LLM Wiki app is active.** It is archived unless the user asks to restore it.
7. **Misdiagnosing Notion MCP gateway failures.** Global Notion MCP config/OAuth can be healthy while the live Discord/gateway MCP client is stale, timing out, or marked unreachable. If logs show `mcp_notion_*` tools existed, do not say the tools were never exposed; say the live Notion MCP connection was unhealthy. Stop repeated identical retries after timeouts/`ClosedResourceError`. For simple read-only Wiki Hub audits, prefer an observable direct MCP/client read path before an opaque nested agent subprocess. If a nested agent session is necessary, bound it tightly and verify with readback. See `references/notion-mcp-gateway-staleness.md`.

## Verification Checklist

- [ ] Wiki Hub or target database/page was fetched or searched when needed
- [ ] Existing page was updated instead of creating an obvious duplicate
- [ ] Source URL or local artifact path was preserved when available
- [ ] Action items were kept in or linked to the Task Hub
- [ ] Final Notion URL(s) were reported to the user
- [ ] Any new schema/rule is described as provisional unless the user explicitly asks to enforce it
