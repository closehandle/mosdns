#!/usr/bin/env bash
if [[ -d '/run/mosdns' ]]; then
    exec mosdns start -c /run/mosdns/mosdns.yaml -d /run/mosdns
else
    exec mosdns start -c /etc/mosdns/mosdns.yaml -d /etc/mosdns
fi

exit 0
