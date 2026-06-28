ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG=C.UTF-8

ARG BUILD_ARCH
ARG HA_CLI_VERSION

# Tailscale (daemon + client) from the Alpine community repo
RUN apk add --no-cache tailscale

# Home Assistant CLI binary (asset name is ha_<arch>, e.g. ha_amd64 / ha_aarch64)
RUN curl -L -s -o /usr/bin/ha \
      "https://github.com/home-assistant/cli/releases/download/${HA_CLI_VERSION}/ha_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/ha

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
