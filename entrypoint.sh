#!/bin/sh
# ╭──────────────────────────────────────────────────────────╮
# │ Nyx Calder Container Entrypoint                          │
# ╰──────────────────────────────────────────────────────────╯

set -e

# Initialize workspace directory
mkdir -p "${OPENCLAW_HOME:-/mnt/volumes/data/openclaw}"

# Execute the command
exec "$@"
