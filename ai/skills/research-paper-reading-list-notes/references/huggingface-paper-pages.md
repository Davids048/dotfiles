# Hugging Face paper pages → Research Reading List

Use this reference when the user provides a Hugging Face Papers URL such as `https://huggingface.co/papers/<arxiv-id>` and asks to add a reading summary or reading-list note.

## Resolution pattern

1. Treat Hugging Face Papers as a wrapper/source, not the canonical paper record.
   - If the URL path contains an arXiv-style ID, normalize the primary database URL to `https://arxiv.org/abs/<id>`.
   - Preserve the Hugging Face page as a labelled source link in the child page body.
   - Also capture any project page, PDF, code, or demo links exposed by the HF page or the arXiv abstract/source.
2. Fetch canonical arXiv metadata and PDF/source using the normal arXiv workflow.
   - Download `https://arxiv.org/pdf/<id>` for PDF text extraction.
   - Try `https://arxiv.org/e-print/<id>` when the versioned source URL is not known; unpacked LaTeX often gives cleaner section, table, appendix, and implementation details than PDF text.
3. Deduplicate using all of: exact title, arXiv ID, canonical arXiv URL, HF wrapper URL, DOI/OpenReview IDs, and project URL.
4. Keep Notion `Notes` status-only.
   - If no accepted venue is found after arXiv/OpenReview/DBLP/Semantic Scholar or proceedings checks, use exactly: `arXiv preprint; no accepted venue found.`
   - Do not put the venue-lookup debug trail in the page body unless the user asks for it.

## Write + verification pattern

- For long summaries, write a self-contained Notion write prompt containing canonical metadata, dedupe keys, source links, exact `Notes` value, and the full 9-question reading summary.
- If using a delegated/fresh Hermes Notion session for the write, run a second read-only verification prompt against the returned page URL/ID before final confirmation.
- Verification should check:
  - Page is under the Research Reading List data source.
  - Title and primary URL are canonical.
  - `Notes` contains only venue/status.
  - HF wrapper link and arXiv link are present in the child page body.
  - All 9 reading-summary question headings are present when full paper text was available.
