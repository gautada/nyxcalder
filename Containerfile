# ╭──────────────────────────────────────────────────────────╮
# │ Nyx Calder - OpenClaw AI Assistant Container            │
# ╰──────────────────────────────────────────────────────────╯

ARG BUILDER_VERSION=bookworm-slim
ARG IMAGE_VERSION=13.3

# ══════════════════════════════════════════════════════════════
# Stage 1: Build OpenClaw from source
# ══════════════════════════════════════════════════════════════
FROM docker.io/library/debian:${BUILDER_VERSION} AS builder

# Install build dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22.x
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# # Install Bun
# RUN curl -fsSL --retry 5 --retry-delay 10 --max-time 600 https://bun.sh/install | bash
# ENV PATH="/root/.bun/bin:${PATH}"

# Enable corepack for pnpm
RUN corepack enable

WORKDIR /build

# Clone OpenClaw
ARG OPENCLAW_VERSION=main
RUN git clone --depth 1 --branch ${OPENCLAW_VERSION} https://github.com/openclaw/openclaw.git .

# Install dependencies, build the application, and build Control UI
RUN pnpm install --frozen-lockfile && \
    pnpm build && \
    pnpm ui:build

# ══════════════════════════════════════════════════════════════
# Stage 2: Runtime container
# ══════════════════════════════════════════════════════════════
FROM docker.io/gautada/debian:${IMAGE_VERSION} AS container

# ┌──────────────────────────────────────────────────────────┐
# │ Runtime Dependencies                                     │
# └──────────────────────────────────────────────────────────┘
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22.x runtime
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# ┌──────────────────────────────────────────────────────────┐
# │ Application Setup                                        │
# └──────────────────────────────────────────────────────────┘
WORKDIR /opt/openclaw

# Copy built application from builder
COPY --from=builder --chown=1001:1001 /build/node_modules ./node_modules
COPY --from=builder --chown=1001:1001 /build/dist ./dist
COPY --from=builder --chown=1001:1001 /build/openclaw.mjs ./openclaw.mjs
COPY --from=builder --chown=1001:1001 /build/package.json ./package.json

# ┌──────────────────────────────────────────────────────────┐
# │ Workspace Configuration                                  │
# └──────────────────────────────────────────────────────────┘
# OpenClaw workspace directory
ENV OPENCLAW_HOME=/home/$USER
# RUN /bin/ln -fsv /mnt/volumes/data "/home/$USER/openclaw" 
# && mkdir -p /opt/openclaw/workspace
# 
# Copy persona configuration
# COPY workspace/SOUL.md /mnt/volumes/configuration/SOUL.md
# COPY workspace/config.yaml /mnt/volumes/configuration/config.yaml
# RUN /bin/ln -fsv /mnt/volumes/configuration/SOUL.md \
#                 /opt/openclaw/workspace/SOUL.md \
#  && /bin/ln -fsv  /mnt/volumes/configuration/config.yaml \
#                   /opt/openclaw/workspace/config.yaml


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
# Rename base container user (debian) to nyx
ARG USER=nyx

RUN /usr/sbin/usermod -l $USER debian \
 && /usr/sbin/usermod -d /home/$USER -m $USER \
 && /usr/sbin/groupmod -n $USER debian \
 && /bin/echo "$USER:$USER" | /usr/sbin/chpasswd \
 && rm -rf /home/debian

# ┌──────────────────────────────────────────────────────────┐
# │ Service Configuration                                    │
# └──────────────────────────────────────────────────────────┘
# COPY entrypoint.sh /usr/bin/container-entrypoint
# RUN chmod +x /usr/bin/container-entrypoint

COPY openclaw-running.sh /etc/container/health.d/openclaw-running
# RUN chmod +x /etc/container/health.d/openclaw-running

COPY version.sh /usr/bin/container-version
# RUN chmod +x /usr/bin/container-version

# s6 service definition
RUN mkdir -p /etc/services.d/openclaw
COPY openclaw-run.sh /etc/services.d/openclaw/run
# RUN chmod +x /etc/services.d/openclaw/run

# ┌──────────────────────────────────────────────────────────┐
# │ Permissions                                              │
# └──────────────────────────────────────────────────────────┘
RUN chown -R $USER:$USER /home/$USER

# ┌──────────────────────────────────────────────────────────┐
# │ Runtime                                                  │
# └──────────────────────────────────────────────────────────┘
ENV NODE_ENV=production
EXPOSE 8080/tcp

# VOLUME ["/mnt/volumes/configuration", "/mnt/volumes/data", "/mnt/volumes/backup", "/mnt/volumes/secrets"]
WORKDIR /home/$USER
ENTRYPOINT ["/usr/bin/s6-svscan", "/etc/services.d"]
