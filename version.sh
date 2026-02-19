#!/bin/sh
# ╭──────────────────────────────────────────────────────────╮
# │ Nyx Calder Version Reporter                              │
# ╰──────────────────────────────────────────────────────────╯

cd /opt/openclaw
node openclaw.mjs --version 2>/dev/null || echo "unknown"
