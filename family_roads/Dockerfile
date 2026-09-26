FROM ghcr.io/nilsnolde/docker-valhalla/valhalla:latest

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends osmium-tool curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY prepare-map.sh /usr/local/bin/prepare-map.sh
COPY run-addon.sh /usr/local/bin/run-addon.sh
RUN chmod 755 /usr/local/bin/prepare-map.sh /usr/local/bin/run-addon.sh

ENTRYPOINT ["/usr/local/bin/run-addon.sh"]
