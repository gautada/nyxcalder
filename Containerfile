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
RUN apt-get update \
 && apt-get upgrade --yes \
 && apt-get install -y --no-install-recommends gh \
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

# ╭――――――――――――――――――――╮
# │ SKILLS             │
# ╰――――――――――――――――――――╯
# Bake skills into ~/.agents/skills — a global pi skill location that is NOT
# shadowed by the /mnt/volumes/data mount (unlike ~/.pi/agent/skills, which is
# a symlink into the volume). Makes these skills a permanent part of the image.
RUN mkdir -p /home/${USER}/.agents/skills

# ╭――――――――――――――――――――╮
# │ CONFIG             │
# ╰――――――――――――――――――――╯
WORKDIR /home/${USER}
RUN chown -R ${USER}:${USER} /home/${USER}


