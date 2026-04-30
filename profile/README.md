# aletheia-works

**Universal bug reproduction in the AI era.**

We build tools that let anyone reproduce a bug — any language, any environment, any scale — so the community can verify what is actually true when AI-generated claims flood issue trackers.

## Active projects

- **[vivarium](https://github.com/aletheia-works/vivarium)** — a controlled environment for reproducing bugs. **Phase 6 — Usability and visual layer (in flight).** Phases 0–5 closed between 2026-04-26 and 2026-04-29: Layer 1 ships six WASM verticals (Pyodide, Ruby.wasm, php-wasm, Rust on `wasm32-wasip1`); Layer 2 ships four Docker recipes published to `ghcr.io/aletheia-works/`; Layer 3 ships one `rr` recipe. Public specs (Contract v1, Manifest v1, Recipes index v1) and a Vivarium MCP server for AI agent clients are published.

## Why "aletheia"?

*Aletheia* (ἀλήθεια) is the ancient Greek word for "unconcealment" — truth understood as what emerges when hidden things are brought into the open. In an era where AI-generated claims flood issue trackers, the work of separating real bugs from plausible-but-false ones is increasingly the work of a truth-disclosure tool.

## Philosophy

- **Problem-centered, not technology-centered.** We reach for WASM, Docker, microVMs, or record-replay based on what the bug demands — never the other way around.
- **Lifelong project.** We plan in decades, not quarters.
- **AI-delegated development.** Human strategy, AI implementation, both held accountable.

## License

All code ships under Apache License 2.0 unless a repository explicitly states otherwise.
