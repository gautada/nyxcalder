# Heartbeat Shortcut

> Issue: [#25](https://github.com/gautada/eurekafarms/issues/25) — “Add a heartbeat execution trigger in Slack”

## Goal

Send the heartbeat command — `Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats.` — with a single keystroke so the agent can be paged without retyping the full text.

## Selected approach — Espanso text snippet (`;;hb`)

Espanso is a cross‑platform, open-source text expander. Once installed, typing `;;hb` expands to the full heartbeat prompt anywhere (Slack DM, channel, etc.). No Slack admin permissions are required and the shortcut works on macOS, Linux, and Windows.

### Installation

1. Install Espanso:
   - **macOS (Homebrew):** `brew install espanso`  
   - **Linux:** see <https://espanso.org/install/linux> (packages + AppImage)  
   - **Windows:** download the MSI from <https://espanso.org/install/windows>
2. Run `espanso service start` (or the installer’s “Start Espanso” button) once to initialize `~/.config/espanso/`.

### Import the snippet

1. Copy the provided match file from this repo:
   ```bash
   cp docs/shortcuts/espanso/heartbeat.yml ~/.config/espanso/match/heartbeat.yml
   ```
2. Reload Espanso so it picks up the new match:
   ```bash
   espanso restart
   ```

### Usage

1. In Slack (DM with Nyx or `#2-development`), type `;;hb` and hit **space**.  
2. Espanso replaces it with the full heartbeat text automatically.  
3. Add any extra context (current time, channel, etc.) **after** the expansion if needed, then send.

### Verification

1. Open Slack, focus the Nyx DM.  
2. Type `;;hb` → confirm it expands to the full command.  
3. Send the message and wait for the agent’s acknowledgement (`HEARTBEAT_OK` or update).  
4. If the command expands but Slack rejects it, ensure you have permission to message the agent/channel.

## Alternative: Slack Workflow Builder (if you prefer UI shortcuts)

1. Slack → **Tools → Workflow Builder → New Workflow**.  
2. Trigger: **Shortcut** (appears under the ⚡ menu).  
3. Step: **Send a message** to the target channel containing the heartbeat text.  
4. Publish the workflow.  
5. When you click ⚡ → choose the workflow → Slack inserts the heartbeat message automatically.

_Notes:_ Workflow shortcuts are per-workspace and require the Workflow Builder feature (paid plans). They do not work in DMs unless you explicitly scope them to the DM.

## Fallback when Espanso is unavailable

- Use Slack’s `/remind me now` to paste the heartbeat text from this document.  
- Or run the OpenClaw CLI directly:  
  ```bash
  openclaw message send \
    --channel slack \
    --target C0AGS5TLY83 \
    --message "Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats."
  ```
  (Replace the target ID if you need a DM instead of `#2-development`.)

Keep the snippet file in version control so future operators can import it quickly after onboarding.
