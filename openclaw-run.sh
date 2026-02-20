#!/bin/sh
# ╭──────────────────────────────────────────────────────────╮
# │ OpenClaw s6 Service Runner                               │
# ╰──────────────────────────────────────────────────────────╯

set -e

_UID=1001
USER=$(getent passwd ${_UID} | cut -d: -f1)
OPENCLAW_HOME="/home/nyx/openclaw"

# Ensure workspace directory exists
mkdir -p "${OPENCLAW_HOME}"

# Link default workspace config if not present
if [ ! -f "${OPENCLAW_HOME}/SOUL.md" ]; then
  cp /opt/openclaw/workspace/SOUL.md "${OPENCLAW_HOME}/SOUL.md"
fi

if [ ! -f "${OPENCLAW_HOME}/config.yaml" ]; then
  cp /opt/openclaw/workspace/config.yaml "${OPENCLAW_HOME}/config.yaml"
fi

# Ensure correct ownership
chown -R ${_UID}:${_UID} "${OPENCLAW_HOME}"

# Change to application directory
cd /opt/openclaw

# Start OpenClaw gateway as user nyx (uid 1001)
exec s6-setuidgid ${USER} node openclaw.mjs gateway \
  --allow-unconfigured \
  --bind lan \
  --port 8080
