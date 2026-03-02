# Models

| Model | Purpose |
| --- | --- |
| anthropic/claude-sonnet-4-6 | Primary agent model |
| openai/gpt-5.1-codex | Fallback #1 |
| google/gemini-3-pro-preview | Fallback #2 |
| google/gemini-3-flash-preview | Heartbeat + image |
| google/gemini-2.0-flash-thinking | Sub-agents |
| openai/gpt-5.2 | Image fallback |

**Aliases configured** (for /model switching):

- sonnet → claude-sonnet-4-6
- opus → claude-opus-4-6
- flash → gemini-3-flash-preview
- codex → gpt-5.1-codex

Note: claude-opus-4-6 is registered as an alias but
has no dedicated purpose defined — it’s available
on demand via /model opus.
