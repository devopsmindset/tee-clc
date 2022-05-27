FROM openjdk:8

ARG TEE_CLC_VERSION

ENV TEE_CLC_VERSION="${TEE_CLC_VERSION:-14.137.0}"
ENV TEE_CLC_PACKAGE="TEE-CLC-${TEE_CLC_VERSION}.zip"

RUN set -x \   
    && apt-get update && apt-get -y install libarchive-tools \
    && curl -fSsL "https://github.com/Microsoft/team-explorer-everywhere/releases/download/${TEE_CLC_VERSION}/${TEE_CLC_PACKAGE}" -O \
    && mkdir -p /opt/tf \
    && bsdtar -C /opt/tf -xf "${TEE_CLC_PACKAGE}" \
    && export PATH="/opt/tf/${TEE_CLC_VERSION}:$PATH"

ENTRYPOINT ["/bin/bash"]
