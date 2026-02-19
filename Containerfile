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
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22.x
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

# Enable corepack for pnpm
RUN corepack enable

WORKDIR /build

# Clone OpenClaw
ARG OPENCLAW_VERSION=main
RUN git clone --depth 1 --branch ${OPENCLAW_VERSION} https://github.com/openclaw/openclaw.git .

# Install dependencies
RUN pnpm install --frozen-lockfile

# Build the application
RUN pnpm build

# Build UI (force pnpm for compatibility)
ENV OPENCLAW_PREFER_PNPM=1
RUN pnpm ui:build

# ══════════════════════════════════════════════════════════════
# Stage 2: Runtime container
# ══════════════════════════════════════════════════════════════
FROM docker.io/gautada/debian:${IMAGE_VERSION} AS container

# ┌──────────────────────────────────────────────────────────┐
# │ Metadata                                                 │
# └──────────────────────────────────────────────────────────┘
LABEL org.opencontainers.image.title="nyxcalder-ai"
LABEL org.opencontainers.image.description="Nyx Calder - Autonomous Cloud-Native Software Engineer running OpenClaw"
LABEL org.opencontainers.image.url="https://github.com/gautada/nyxcalder"
LABEL org.opencontainers.image.source="https://github.com/gautada/nyxcalder"
LABEL org.opencontainers.image.documentation="https://github.com/gautada/nyxcalder/blob/main/README.md"

# ┌──────────────────────────────────────────────────────────┐
# │ Application User                                         │
# └──────────────────────────────────────────────────────────┘
ARG APP_USER=nyx
ARG APP_UID=1001
ARG APP_GID=1001

USER root

# Create application user if different from base
RUN if ! id -u ${APP_USER} > /dev/null 2>&1; then \
      groupadd -g ${APP_GID} ${APP_USER} && \
      useradd -u ${APP_UID} -g ${APP_GID} -m -s /bin/zsh ${APP_USER}; \
    fi

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
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# ┌──────────────────────────────────────────────────────────┐
# │ Application Setup                                        │
# └──────────────────────────────────────────────────────────┘
WORKDIR /opt/openclaw

# Copy built application from builder
COPY --from=builder /build/node_modules ./node_modules
COPY --from=builder /build/dist ./dist
COPY --from=builder /build/ui/dist ./ui/dist
COPY --from=builder /build/openclaw.mjs ./openclaw.mjs
COPY --from=builder /build/package.json ./package.json

# ┌──────────────────────────────────────────────────────────┐
# │ Workspace Configuration                                  │
# └──────────────────────────────────────────────────────────┘
# OpenClaw workspace directory
ENV OPENCLAW_HOME=/mnt/volumes/data/openclaw

# Copy persona configuration
COPY workspace/SOUL.md /opt/openclaw/workspace/SOUL.md
COPY workspace/config.yaml /opt/openclaw/workspace/config.yaml

# ┌──────────────────────────────────────────────────────────┐
# │ Service Configuration                                    │
# └──────────────────────────────────────────────────────────┘
COPY entrypoint.sh /usr/bin/container-entrypoint
RUN chmod +x /usr/bin/container-entrypoint

COPY health.sh /usr/bin/container-health
RUN chmod +x /usr/bin/container-health

COPY version.sh /usr/bin/container-version
RUN chmod +x /usr/bin/container-version

# s6 service definition
RUN mkdir -p /etc/services.d/openclaw
COPY openclaw-run.sh /etc/services.d/openclaw/run
RUN chmod +x /etc/services.d/openclaw/run

# ┌──────────────────────────────────────────────────────────┐
# │ Permissions                                              │
# └──────────────────────────────────────────────────────────┘
RUN chown -R ${APP_USER}:${APP_USER} /opt/openclaw && \
    chown -R ${APP_USER}:${APP_USER} /mnt/volumes

# ┌──────────────────────────────────────────────────────────┐
# │ Runtime                                                  │
# └──────────────────────────────────────────────────────────┘
ENV NODE_ENV=production
EXPOSE 5173/tcp

VOLUME ["/mnt/volumes/configuration", "/mnt/volumes/data", "/mnt/volumes/backup", "/mnt/volumes/secrets"]
WORKDIR /
ENTRYPOINT ["/usr/bin/s6-svscan", "/etc/services.d"]
