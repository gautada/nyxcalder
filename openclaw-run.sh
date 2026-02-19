#!/bin/sh
# ╭──────────────────────────────────────────────────────────╮
# │ OpenClaw s6 Service Runner                               │
# ╰──────────────────────────────────────────────────────────╯

set -e

# Ensure workspace directory exists
mkdir -p "${OPENCLAW_HOME:-/mnt/volumes/data/openclaw}"

# Link default workspace config if not present
if [ ! -f "${OPENCLAW_HOME}/SOUL.md" ]; then
  cp /opt/openclaw/workspace/SOUL.md "${OPENCLAW_HOME}/SOUL.md"
fi

if [ ! -f "${OPENCLAW_HOME}/config.yaml" ]; then
  cp /opt/openclaw/workspace/config.yaml "${OPENCLAW_HOME}/config.yaml"
fi

# Change to application directory
cd /opt/openclaw

# Start OpenClaw gateway
exec node openclaw.mjs gateway \
  --allow-unconfigured \
  --bind lan \
  --workspace "${OPENCLAW_HOME}"
