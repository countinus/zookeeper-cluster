ARG VERSION=3.5
FROM zookeeper:${VERSION}

LABEL maintainer="Countinus Lab <countinus.dev@gmail.com>"

ENV SERVICE_NAME zookeeper

ENV ZOO_TICK_TIME 2000
ENV ZOO_INIT_LIMIT 5
ENV ZOO_SYNC_LIMIT 2
ENV ZOO_STANDALONE_ENABLED true
ENV ZOO_RECONFIG_ENABLED true
ENV ZOO_SKIP_ACL yes
ENV ZOO_DYNAMIC_CONFIG_FILE $ZOO_CONF_DIR/zoo.cfg.dynamic

RUN apk add --update bind-tools curl jq

COPY --chown=0:0 scripts/*.* /usr/local/bin/

RUN echo 0 | tee /usr/local/bin/INITIALIZED >> /dev/null && \
    echo 0 | tee /usr/local/bin/HEALTHY >> /dev/null

HEALTHCHECK --interval=20s --timeout=10s --start-period=1m20s \
  CMD healthcheck.sh

ENTRYPOINT entrypoint.sh
CMD ["zkServer.sh", "start-foreground"]
