# User-level instructions

## No manual line wrapping

Do not insert hard line breaks to wrap prose at ~80 columns. This applies everywhere I produce text:

- **Files I write or edit** — markdown, plain text, prose docs of any kind. One paragraph = one line. Let the editor autowrap.
- **My terminal responses** — the text you read in chat. Same rule: each paragraph and each bullet body is one continuous line, no manual mid-paragraph breaks. Hard wraps look fine in the terminal but paste catastrophically into anything else.

What still gets line breaks (these are real structure, not wrapping):

- Blank lines between paragraphs, around lists, around headings, around code fences.
- Line breaks inside code blocks, tables, and any structured content where breaks are part of the syntax.
- Distinct bullet items in a list (each bullet is its own line; the bullet's *body* still stays on one line).
- Code in actual source files (Go, Python, YAML, HCL, shell, etc.) — that follows the language's own conventions and the project's formatter (gofmt, black, prettier, etc.). Don't reflow code.

The pain point this addresses: copy-pasting hard-wrapped prose out of the terminal into Slack, docs, tickets, etc. produces broken-looking paragraphs with stray line breaks. Autowrap-style text pastes cleanly everywhere.
