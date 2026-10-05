FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cec-utils \
        whiptail \
        shellcheck \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/tv-control
COPY tv-control.sh tvon.sh tvoff.sh tvstat.sh tvsource.sh ./
RUN chmod +x *.sh

ENTRYPOINT ["tv-control.sh"]
CMD ["menu"]
