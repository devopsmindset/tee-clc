FROM openjdk

ARG TEE_CLC_VERSION

ENV TEE_CLC_VERSION="${TEE_CLC_VERSION:-14.137.0}" PATH=/opt/tf:$PATH PUID=$PUID PGID=$PGID
ENV TEE_CLC_PACKAGE="TEE-CLC-${TEE_CLC_VERSION}.zip"

RUN set -x \
    && apt-get update && apt-get install -y curl bsdtar gnome-keyring --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && curl -fSsL "https://github.com/Microsoft/team-explorer-everywhere/releases/download/v${TEE_CLC_VERSION}/${TEE_CLC_PACKAGE}" -O \
    && mkdir -p /opt/tf \
    && bsdtar -xf "${TEE_CLC_PACKAGE}" -C /opt/tf -s'|[^/]*/||' --uid $PUID --gid $PGID \
    && rm "${TEE_CLC_PACKAGE}" \
    && apt-get purge -y --auto-remove curl bsdtar

ENTRYPOINT ["/bin/bash"]
