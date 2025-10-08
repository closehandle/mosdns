FROM alpine:latest

RUN apk add --no-cache unzip curl && \
    mkdir downloads && cd downloads && \
    curl -Lo mosdns-linux-amd64.zip https://github.com/pmkol/mosdns-x/releases/download/v25.10.08/mosdns-linux-amd64.zip && \
    unzip mosdns-linux-amd64.zip && mv -f mosdns /usr/bin && \
    cd .. && rm -fr downloads

FROM alpine:latest
COPY --from=0 /usr/bin/mosdns /usr/bin/mosdns

RUN apk add --no-cache ca-certificates bash
ADD mosdns.yaml /etc/mosdns/mosdns.yaml
ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

FROM scratch
COPY --from=1 / /
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
