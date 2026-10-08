ARG DEBIAN_VERSION=13.6
ARG HERMES_VERSION=0.84.4


FROM docker.io/gautada/hermes:${HERMES_VERSION}

# ╭――――――――――――――――――╮
# │ METADATA         │
# ╰――――――――――――――――――╯
LABEL org.opencontainers.image.title="nyxcalder"
LABEL org.opencontainers.image.description="A specific agent harness: Nyx Calder - Software Engineer"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/gautada/nyxcalder"
LABEL org.opencontainers.image.source="https://github.com/gautada/nyxcalder"
LABEL org.opencontainers.image.license="Liscense"

# ╭――――――――――――――――――╮
# │ PACKAGES         │
# ╰――――――――――――――――――╯
# hadolint ignore=DL3016
RUN printf 'Acquire::Retries "3";\nAcquire::http::Timeout "15";\nAcquire::https::Timeout "15";\n' \
      > /etc/apt/apt.conf.d/99-retry \
 && apt-get update \
 && apt-get --yes --no-install-recommends upgrade \
 && apt-get install --yes --no-install-recommends \
      gh podman \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# ╭――――――――――――――――――――╮
# │ USER               │
# ╰――――――――――――――――――――╯
# Rename the base user to this container user.
# Follows the same pattern as other gautada containers.
ARG OLDUSER=hermes
ARG USER=nyx
RUN /usr/sbin/usermod -l $USER $OLDUSER \
 && /usr/sbin/usermod -d /home/$USER -m $USER \
 && /usr/sbin/groupmod -n $USER $OLDUSER \
 && PASSWORD="$(openssl rand -base64 32 | tr -dc 'A-Za-z0-9' | head -c 24)" \
 && printf '%s:%s\n' "$USER" "$PASSWORD" | /usr/sbin/chpasswd

# ╭――――――――――――――――――――╮
# │ APPLICATION        │
# ╰――――――――――――――――――――╯
WORKDIR /home/${USER}
RUN ln -fsv /mnt/volumes/configuration/_gitconfig .gitconfig
WORKDIR /home/${USER}/.agents/skills
# foo...
WORKDIR /home/${USER}/.config/containers
RUN ln -fsv /mnt/volumes/configuration/podman-connections.json \
           podman-connections.json
WORKDIR /home/${USER}/.config/tirith
RUN ln -fsv /mnt/volumes/configuration/policy.yaml policy.yaml

# ╭――――――――――――――――――――╮
# │ CONFIG             │
# ╰――――――――――――――――――――╯
WORKDIR /home/${USER}
RUN chown -R ${USER}:${USER} /home/${USER}


