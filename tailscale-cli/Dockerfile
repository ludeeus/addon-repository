ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG=C.UTF-8

ARG BUILD_ARCH
ARG TAILSCALE_VERSION
ARG HA_CLI_VERSION

# Tailscale official static binaries -> /opt, symlinked into PATH.
# BUILD_ARCH (amd64/aarch64) is mapped to Tailscale's arch naming (amd64/arm64).
RUN \
    case "${BUILD_ARCH}" in \
      amd64) TS_ARCH="amd64" ;; \
      aarch64) TS_ARCH="arm64" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" >&2; exit 1 ;; \
    esac \
    && mkdir -p /opt \
    && curl -fsSL \
        "https://pkgs.tailscale.com/stable/tailscale_${TAILSCALE_VERSION#v}_${TS_ARCH}.tgz" \
        | tar zxf - -C /opt/ --strip-components 1 \
    && ln -s /opt/tailscale /usr/bin/tailscale \
    && ln -s /opt/tailscaled /usr/bin/tailscaled

# Home Assistant CLI binary (asset name is ha_<arch>, e.g. ha_amd64 / ha_aarch64)
RUN curl -fsSL -o /usr/bin/ha \
      "https://github.com/home-assistant/cli/releases/download/${HA_CLI_VERSION}/ha_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/ha

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
