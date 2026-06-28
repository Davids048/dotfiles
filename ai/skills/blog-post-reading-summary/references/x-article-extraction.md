# X Article Extraction for Blog-Style Reading Summaries

Use this when the user gives an X/Twitter status URL that is really an X Article / long-form post and asks for a reading-list/blog-style summary.

## Practical extraction pattern

1. Parse the status ID from the URL, e.g. `https://x.com/drfeifei/status/2062247238143996275` → `2062247238143996275`.
2. Try public embed/mirror endpoints before giving up on the source text:
   - `https://api.fxtwitter.com/status/<status_id>`
   - `https://api.vxtwitter.com/<handle>/status/<status_id>` when the handle is known
   - `https://publish.twitter.com/oembed?url=<encoded status URL>` for author/date/embed metadata
3. In the `api.fxtwitter.com` response, inspect `tweet.article`:
   - `article.title`
   - `article.id`
   - `article.preview_text`
   - `article.content.blocks[]`
4. Convert `article.content.blocks[]` into readable markdown:
   - `header-two` → `## ...`
   - `header-three` → `### ...`
   - `blockquote` → `> ...`
   - `unstyled` → paragraph text
5. Preserve provenance in the Notion page body:
   - Original X status URL
   - X Article ID when present
   - Author/source and date
   - Short extraction note if the official X API/CLI was unavailable and public mirrors were used

## Summary-writing guidance

For X Articles, treat the source as a blog/essay unless it clearly resolves to a canonical research paper. Use the blog-post summary structure: TL;DR, main theme, main argument, why it matters, concepts, interpretation, and one-sentence takeaway.

Avoid treating a long-form X Article as a paper simply because it discusses research topics. Do not invent experiments, sections, or citations beyond the article text.
