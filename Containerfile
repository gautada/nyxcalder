# ╭──────────────────────────────────────────────────────────╮
# │ eureka!FARMS - OpenClaw AI Assistant Container           │
# ╰──────────────────────────────────────────────────────────╯

ARG BASE_VERSION=latest

# ══════════════════════════════════════════════════════════════
# Stage 1: Build OpenClaw from source
# ══════════════════════════════════════════════════════════════
# FROM docker.io/library/node:22-trixie AS builder
FROM docker.io/gautada/openclaw:$BASE_VERSION AS container
# FROM docker.io/gautada/debian:13.3 AS container

# ┌──────────────────────────────────────────────────────────┐
# │ Metadata                                                 │
# └──────────────────────────────────────────────────────────┘
LABEL org.opencontainers.image.title="eurekafarms"
LABEL org.opencontainers.image.description="Autonomous Cloud-Native Software Team"
LABEL org.opencontainers.image.url="https://github.com/gautada/eurekafarms"
LABEL org.opencontainers.image.source="https://github.com/gautada/eurekafarms"
LABEL org.opencontainers.image.documentation="https://github.com/gautada/eurekafarms/blob/main/README.md"

# ┌──────────────────────────────────────────────────────────┐
# │ Application User                                         │
# └──────────────────────────────────────────────────────────┘
# Tools and such for the cohort that are just avaialable in the
# typical debian repos.
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
            gh shellcheck python3-pip pipx gnupg git \
 && rm -rf /var/lib/apt/lists/* \
 && pipx install pre-commit \
 && curl -sSL \
    https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-arm64 \
    -o /usr/local/bin/hadolint && chmod +x /usr/local/bin/hadolint

# ┌──────────────────────────────────────────────────────────┐
# │ kubectl                                                  │
# └──────────────────────────────────────────────────────────┘
RUN mkdir -p /etc/apt/keyrings \
 && curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key \
    | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
 && echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' \
    > /etc/apt/sources.list.d/kubernetes.list \
 && apt-get update \
 && apt-get install --yes --no-install-recommends kubectl \
 && apt-get purge --yes gnupg \
 && apt-get autoremove --yes \
 && rm -rf /var/lib/apt/lists/* \
 && pipx install --global pre-commit \
 && curl -sSfL https://raw.githubusercontent.com/dotenv-linter/dotenv-linter/master/install.sh | sh -s -- -b /usr/local/bin

# RUN apt-get update \
#  && apt-get install --yes --no-install-reccomends ripgrep nodejs npm 

# COPY openclaw-control.sh /usr/bin/openclaw
COPY bin/process-input.zsh /usr/bin/process-input
# ┌──────────────────────────────────────────────────────────┐
# │ Service Configuration                                    │
# └──────────────────────────────────────────────────────────┘
RUN rm -rf /home/cheliped \
 && /bin/ln -fsv /mnt/volumes/data /home/cheliped \
 && chown -R cheliped:cheliped /home/cheliped
