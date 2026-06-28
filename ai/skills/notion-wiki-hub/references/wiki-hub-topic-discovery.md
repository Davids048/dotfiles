# Wiki Hub topic discovery across compiled pages, raw sources, and reading-list pages

Use this when David asks to find all Wiki Hub material related to a research topic, especially when the topic may span Wiki Pages, Raw Sources, and Research Reading List paper notes.

## Pattern

1. **Orient on the Wiki Hub, not just one database.** The Wiki Hub contains compiled `Wiki Pages`, non-paper `Raw Sources`, and an embedded Task Hub `Research Reading List` view. Topic discovery usually needs all three.
2. **Start from concept/index pages.** Search broad terms first (for example `RL video generation`, `reward video generation`, `GRPO video generation`, `DPO video generation`). Fetch promising concept/index pages and read their linked anchors before deciding final relevance.
3. **Follow Notion mentions/backlinks.** Concept pages often contain `<mention-page ...>` links to Research Reading List pages that are canonical paper-note pages. Fetch those pages directly and verify their properties/body, rather than relying only on search snippets.
4. **Search the embedded Research Reading List view when papers are likely.** The Wiki Hub may embed the Research Reading List as a database/data-source under the hub. For paper-heavy topics, search that data source directly after finding its data-source URL.
5. **Verify candidate relevance before reporting.** For each candidate, fetch the page and extract: Notion page title, Notion URL, canonical/source URL, and the specific reason it relates to the user’s topic. Drop pages that only match a broad adjacent word unless useful as “nearby/context.”
6. **Separate result tiers.** Report concise groups such as: directly related papers/pages; concept/index pages; raw-source/infrastructure pages; reward/eval anchors; nearby but less direct. This is much easier to scan than a single flat dump.
7. **Preserve canonical direction.** If a Wiki Pages concept index points to Research Reading List paper-note pages, treat the RRL pages as the canonical paper notes unless page content says otherwise.

## Useful search terms for RL/video-generation style topics

Use a mix of method names, task terms, and evaluator/reward terms:

- `RL video generation`
- `reinforcement learning video generation`
- `GRPO video generation`
- `DPO video generation reward`
- `VideoReward VideoAlign RL training`
- `DanceGRPO DenseDPO Flow-DPO video`
- `joint audio-video reinforcement reward optimization`
- `VidProM VideoJAM MotionBench VisionReward`
- `VBench human preference video generation`

## Output shape

Keep the final answer concise. For each verified page include:

- page name
- Notion URL
- source/canonical URL when available
- one short relevance sentence

Avoid long snippets unless the user asks for evidence/details. For Discord readability, prefer bullets over tables.