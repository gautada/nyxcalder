# Slack @Mention Requirements

In multi-agent Slack channels (like `#2-development`), agents are configured with `ackReactionScope: "group-mentions"`.

## Behavior
- Agents will **only** respond or acknowledge messages that explicitly @mention them (e.g., `@nyxcalder`).
- Messages without a specific @mention will be ignored by the agents to prevent noise in shared channels.

## Best Practices
- Always tag the specific agent you are addressing.
- If you need a general response, pick the agent most relevant to the task (e.g., `@blairplan` for planning, `@nyxcalder` for development).

## Configuration Note
This behavior is controlled by the `ackReactionScope` setting in the OpenClaw channel configuration.
