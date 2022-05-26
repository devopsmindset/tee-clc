FROM openjdk

ARG TEE_CLC_VERSION

ENV TEE_CLC_VERSION="${TEE_CLC_VERSION:-14.137.0}" PATH=/opt/tf:$PATH
ENV TEE_CLC_PACKAGE="TEE-CLC-${TEE_CLC_VERSION}.zip"

RUN apt-get install -y bsdtar

RUN set -x \   
    && curl -fSsL "https://github.com/Microsoft/team-explorer-everywhere/releases/download/${TEE_CLC_VERSION}/${TEE_CLC_PACKAGE}" -O \
    && mkdir -p /opt/tf \
    && bsdtar -xf "${TEE_CLC_PACKAGE}" -C /opt/tf

ENTRYPOINT ["/bin/bash"]
