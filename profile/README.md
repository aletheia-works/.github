# aletheia-works

**Universal bug reproduction in the AI era.**

We build tools that let anyone reproduce a bug — any language, any environment, any scale — so the community can verify what is actually true when AI-generated claims flood issue trackers.

## Projects

- **[vivarium](https://github.com/aletheia-works/vivarium)** — a catalogue of reproductions of real bugs in open-source projects. Open one and see for yourself whether the bug still happens: every reproduction ends in a verdict, `reproduced` or `unreproduced`, with the output it is based on. Reproductions run in your browser through WebAssembly, in Docker images published to `ghcr.io/aletheia-works/`, or as live previews of a whole application. You can also paste an error message to find matching reproductions, compare two verdicts to see whether a fix worked, and search the catalogue from an AI agent through the Vivarium MCP server. [Website](https://aletheia-works.github.io/vivarium/)
- **[paludarium](https://github.com/aletheia-works/paludarium)** — a user-mode x86-64 Linux emulator written in Rust. It runs unmodified x86-64 Linux programs on Linux, macOS and Windows, and in WebAssembly (Node.js and browsers) with a WebAssembly JIT. [Documentation](https://aletheia-works.github.io/paludarium/)
- **[formicarium](https://github.com/aletheia-works/formicarium)** — runs unmodified x86-64 Linux command-line programs in the browser and in Node.js, with no kernel to boot. It wraps paludarium in a small JavaScript API so a CLI bug reproduction can run as-is in a web page. [Showcase](https://aletheia-works.github.io/formicarium/)
- **[coi-serviceworker](https://github.com/aletheia-works/coi-serviceworker)** — cross-origin isolation for static hosts such as GitHub Pages, through a service worker, so pages there can use `SharedArrayBuffer`. [npm](https://www.npmjs.com/package/@aletheia-works/coi-serviceworker)

Packages are published on npm, crates.io and JSR under the `@aletheia-works` and `paludarium` names.

## Why "aletheia"?

*Aletheia* (ἀλήθεια) is the ancient Greek word for "unconcealment" — truth understood as what emerges when hidden things are brought into the open. In an era where AI-generated claims flood issue trackers, the work of separating real bugs from plausible-but-false ones is increasingly the work of a truth-disclosure tool.

## Philosophy

- **Problem-centered, not technology-centered.** We reach for WebAssembly, Docker, emulators or live previews based on what the bug demands — never the other way around.
- **Lifelong project.** We plan in decades, not quarters.
- **AI-delegated development.** Human strategy, AI implementation, both held accountable.

## Join us

We are looking for people who want to work on these projects with us. If you would like to join, email [jambalaya.pyoncafe@outlook.jp](mailto:jambalaya.pyoncafe@outlook.jp) and tell us a little about yourself and what you would like to work on.

To report a bug or suggest a change to a single project, open an issue in that repository instead.

## License

All code ships under Apache License 2.0 unless a repository explicitly states otherwise.
