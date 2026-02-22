# ╭──────────────────────────────────────────────────────────╮
# │ Nyx Calder - OpenClaw AI Assistant Container            │
# ╰──────────────────────────────────────────────────────────╯

ARG CONTAINER_VERSION=dev

# ══════════════════════════════════════════════════════════════
# Stage 1: Build OpenClaw from source
# ══════════════════════════════════════════════════════════════
# FROM docker.io/library/node:22-trixie AS builder
FROM docker.io/gautada/openclaw:$CONTAINER_VERSION AS container

# ┌──────────────────────────────────────────────────────────┐
# │ Metadata                                                 │
# └──────────────────────────────────────────────────────────┘
LABEL org.opencontainers.image.title="nyxcalder"
LABEL org.opencontainers.image.description="Nyx Calder - Autonomous Cloud-Native Software Engineer running OpenClaw"
LABEL org.opencontainers.image.url="https://github.com/gautada/nyxcalder"
LABEL org.opencontainers.image.source="https://github.com/gautada/nyxcalder"
LABEL org.opencontainers.image.documentation="https://github.com/gautada/nyxcalder/blob/main/README.md"

# ┌──────────────────────────────────────────────────────────┐
# │ Application User                                         │
# └──────────────────────────────────────────────────────────┘
# Rename base container user (cheliped) to nyx
ARG OLD_USER=cheliped
ARG USER=nyx

RUN /usr/sbin/usermod -l "$USER" "$OLD_USER" \
 && /usr/sbin/usermod -d /home/$USER -m $USER \
 && /usr/sbin/groupmod -n $USER $OLD_USER \
 && /bin/echo "$USER:$USER" | /usr/sbin/chpasswd \
 && rm -rf /home/$OLD_USER \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
            chromium ca-certificates fonts-liberation fontconfig libnss3 \
            libxss1 libasound2 libatk-bridge2.0-0 libgtk-3-0 libgbm1 \
            libdrm2 libxdamage1 libxrandr2 libxcomposite1 libxfixes3 \
            libxkbcommon0 libpango-1.0-0 libcairo2 libatspi2.0-0 libglib2.0-0 \
            libdbus-1-3 \
 && rm -rf /var/lib/apt/lists/*

COPY openclaw-control.sh /usr/bin/openclaw
# ┌──────────────────────────────────────────────────────────┐
# │ Service Configuration                                    │
# └──────────────────────────────────────────────────────────┘
RUN rm -rf /home/$USER \
 && /bin/ln -fsv /mnt/volumes/data /home/$USER \
 && chown -R $USER:$USER /home/$USER
