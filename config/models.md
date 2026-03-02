| Model | Purpose |
|---|---|
| anthropic/claude-sonnet-4-6 | **Primary agent model** — all agents default to this for main conversation/reasoning |
| openai/gpt-5.1-codex | **Fallback #1** — if Sonnet is unavailable; also the fallback for image tasks |
| google/gemini-3-pro-preview | **Fallback #2** — secondary fallback for agent runs |
| google/gemini-3-flash-preview | **Heartbeat** (every 30m) + **primary image model** — lightweight, fast; used for periodic health checks and image generation |
| google/gemini-2.0-flash-thinking | **Sub-agents** — spawned background tasks run on this model |
| openai/gpt-5.2 | **Image fallback** — if Gemini Flash fails for image generation |

**Aliases configured** (for /model switching):
- sonnet → claude-sonnet-4-6
- opus → claude-opus-4-6
- flash → gemini-3-flash-preview
- codex → gpt-5.1-codex

Note: claude-opus-4-6 is registered as an alias but has no dedicated purpose defined — it's available on demand via /model opus. (edited)
