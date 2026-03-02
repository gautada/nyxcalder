# slack

## Setup Notes

Socket Mode is the way to go — no public URL needed.
Here’s what you need to do:

### Step 1 — Create a Slack App

Go to api.slack.com/apps → Create New App →
From scratch.
Name it (e.g. "First Last") and pick your workspace.

### Step 2 — Enable Socket Mode

Go to Socket Mode → toggle it on.
It’ll prompt you to create an App Token with
`connections:write` scope → save it (xapp-...).

### Step 3 — Get Bot Token

Go to OAuth & Permissions → Bot Token Scopes, add:

- `app_mentions:read`
- `chat:write`
- `channels:history`
- `im:history`
- `im:write`
- `reactions:write`
- `files:write`

Click Install to Workspace → copy the Bot User
OAuth Token (xoxb-...).

### Step 4 — Subscribe to Events

Go to **Event Subscriptions** → enable, then add
these Bot Events:

- `app_mention`
- `message.channels`
- `message.groups`
- `message.im`
- `message.mpim`

### Step 5 — Enable Messages Tab (for DMs)

Go to **App Home** → enable Messages Tab.

### Step 6 — Add to openclaw.json

channels:

```json
{
  "slack": {
    "enabled": true,
    "mode": "socket",
    "appToken": "xapp-...",
    "botToken": "xoxb-..."
  }
}
```

OpenClaw supports `${VAR_NAME}` substitution in
config values. So you can keep all tokens in the
env block and reference them:

```json
{
  "env": {
    "SLACK_APP_TOKEN": "xapp-...",
    "SLACK_BOT_TOKEN": "xoxb-...",
    "SLACK_CICD_APP_TOKEN": "xapp-...",
    "SLACK_CICD_BOT_TOKEN": "xoxb-..."
  },
  "channels": {
    "slack": {
      "enabled": true,
      "mode": "socket",
      "appToken": "${SLACK_APP_TOKEN}",
      "botToken": "${SLACK_BOT_TOKEN}",
      "accounts": {
        "cicd": {
          "appToken": "${SLACK_CICD_APP_TOKEN}",
          "botToken": "${SLACK_CICD_BOT_TOKEN}"
        }
      }
    }
  }
}
```
