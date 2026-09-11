ARG DEBIAN_VERSION=13.6
ARG PI_VERSION=0.84.4

FROM docker.io/gautada/debian:${DEBIAN_VERSION} AS SKILLS

# hadolint ignore=DL3008
RUN apt-get update \
 && apt-get upgrade --yes \
 && apt-get install --yes --no-install-recommends \
            git golang-go \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
# Should develop a concept of pinning the version
RUN git clone --depth 1 https://github.com/leunguu/pi-agent-config \
 && git clone --depth 1 https://github.com/badlogic/pi-skills \
 && git clone --depth 1 https://github.com/mattpocock/skills mattpocock-skills

FROM docker.io/gautada/pi:${PI_VERSION}

# ╭――――――――――――――――――╮
# │ METADATA         │
# ╰――――――――――――――――――╯
LABEL org.opencontainers.image.title="nyxcalder"
LABEL org.opencontainers.image.description="A specific pi agent harness: Nyx Calder - Software Engineer"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/gautada/ren"
LABEL org.opencontainers.image.source="https://github.com/gautada/ren"
LABEL org.opencontainers.image.license="Liscense"

# ╭――――――――――――――――――╮
# │ PACKAGES         │
# ╰――――――――――――――――――╯
# hadolint ignore=DL3016
RUN apt-get update \
 && apt-get upgrade --yes \
 && apt-get install -y --no-install-recommends \
    openssh-client gh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# ╭――――――――――――――――――――╮
# │ USER               │
# ╰――――――――――――――――――――╯
# Rename the base user to this container user.
# Follows the same pattern as other gautada containers.
ARG OLDUSER=slice
ARG USER=nyx
RUN /usr/sbin/usermod -l $USER $OLDUSER \
 && /usr/sbin/usermod -d /home/$USER -m $USER \
 && /usr/sbin/groupmod -n $USER $OLDUSER \
 && PASSWORD="$(openssl rand -base64 32 | tr -dc 'A-Za-z0-9' | head -c 24)" \
 && printf '%s:%s\n' "$USER" "$PASSWORD" | /usr/sbin/chpasswd

# ╭――――――――――――――――――――╮
# │ SKILLS             │
# ╰――――――――――――――――――――╯
# Bake skills into ~/.agents/skills — a global pi skill location that is NOT
# shadowed by the /mnt/volumes/data mount (unlike ~/.pi/agent/skills, which is
# a symlink into the volume). Makes these skills a permanent part of the image.
RUN mkdir -p /home/${USER}/.agents/skills

COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/pi-agent-config/skills/pi-skill-developer \
     /home/${USER}/.agents/skills/pi-skill-developer

COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/engineering/diagnosing-bugs \
     /home/${USER}/.agents/skills/diagnosing-bugs
COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/engineering/domain-modeling \
     /home/${USER}/.agents/skills/domain-modeling
COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/engineering/prototype \
     /home/${USER}/.agents/skills/prototype
COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/engineering/research \
     /home/${USER}/.agents/skills/research
COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/engineering/wayfinder \
     /home/${USER}/.agents/skills/wayfinder

COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/productivity/grilling \
     /home/${USER}/.agents/skills/grilling
COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/productivity/handoff \
     /home/${USER}/.agents/skills/handoff
COPY --from=SKILLS --chown=${USER}:${USER} \
     /opt/mattpocock-skills/skills/productivity/writing-for-agents \
     /home/${USER}/.agents/skills/writing-for-agents

# ╭――――――――――――――――――――╮
# │ CONFIG             │
# ╰――――――――――――――――――――╯
WORKDIR /home/${USER}
RUN ln -fsv /mnt/volumes/configuration/.gitconfig .gitconfig \
 && chown -R ${USER}:${USER} /home/${USER}

