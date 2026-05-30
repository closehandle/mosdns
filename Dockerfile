FROM alpine:latest

ADD mosdns-rules.sh /usr/bin/mosdns-rules.sh
RUN apk add --no-cache unzip bash curl && \
    mkdir downloads && cd downloads && \
    curl -Lo mosdns-linux-amd64.zip https://github.com/pmkol/mosdns-x/releases/download/v26.05.25/mosdns-linux-amd64.zip && \
    unzip mosdns-linux-amd64.zip && mv -f mosdns /usr/bin && \
    cd .. && rm -fr downloads && \
    mosdns-rules.sh

FROM alpine:latest
COPY --from=0 /ads.list /etc/mosdns/ads.list
COPY --from=0 /chinadns.list /etc/mosdns/chinadns.list
COPY --from=0 /otherdns.list /etc/mosdns/otherdns.list
COPY --from=0 /usr/bin/mosdns /usr/bin/mosdns

RUN apk add --no-cache ca-certificates bash
ADD mosdns.yaml /etc/mosdns/mosdns.yaml
ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

FROM scratch
COPY --from=1 / /
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
