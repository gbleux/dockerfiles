# VERSION           0.1.0
# DOCKER-VERSION    1.5.0
FROM justin8/archlinux:latest
MAINTAINER Gordon Bleux <gordon.bleux+dmpa@gmail.com> (@gbleux)

# non-root user required for makepkg.
# UID might not match with user outside of container
ENV MAKEPKG_USER=developer \
    MAKEPKG_GROUP=developer \
    MAKEPKG_ROOT=/data
RUN groupadd "${MAKEPKG_USER}" \
    && useradd -g "${MAKEPKG_GROUP}" "${MAKEPKG_USER}"

# build image manually for fastest mirrors
RUN curl -SL "https://www.archlinux.org/mirrorlist/?country=all&use_mirror_status=on&protocol=http&ip_version=4" \
    | sed 's/^#Server/Server/g' \
    > /etc/pacman.d/mirrorlist

# minimum requirement for AUR/abs usage.
# this installs sudo among other packages
RUN pacman --noconfirm --needed -Syu \
    && pacman --noconfirm --needed -S base-devel \
    && pacman -Scc

# privilege elevation utility which is better suited for container environment
# source:
# https://github.com/docker-library/postgres/blob/c9d9f4c1a0d33a161fefda666f041ef0dc4dc9f8/9.4/Dockerfile
ENV GOSU_VERSION=1.3 \
    GOSU_KEY=B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN gpg --keyserver pgp.mit.edu --recv-keys "${GOSU_KEY}"
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod 4755 /usr/local/bin/gosu

# /usr/local/bin is in PATH before /usr/bin,
# therefor the original sudo is shadowed by the shim
COPY sudo-shim.sh /usr/local/bin/sudo-shim
RUN chmod 4755 /usr/local/bin/sudo-shim \
    && ln -s /usr/local/bin/sudo-shim /usr/local/bin/sudo

# allow non-interactive usage of sudo if gosu cannot be used
COPY sudoers /etc/sudoers.d/makepkg
RUN sed -i "s/@USER@/${MAKEPKG_USER}/g" /etc/sudoers.d/makepkg \
    && chmod 0440 /etc/sudoers.d/makepkg \
    && visudo --strict --check

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod 0755 /entrypoint.sh

VOLUME ["${MAKEPKG_ROOT}"]
WORKDIR ${MAKEPKG_ROOT}

# entrypoint drops privileges when running makepkg
# otherwise root remains active user
ENTRYPOINT ["/entrypoint.sh"]
CMD ["makepkg", "--noconfirm", "--needed", "-sfc"]
