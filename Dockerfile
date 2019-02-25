FROM alpine

MAINTAINER IV8<admin@30m.cloud>

ENV KEY=12345

COPY .git /root/shadowsocks/.git

WORKDIR /root/shadowsocks

RUN apk --no-cache add curl python python-dev libsodium-dev openssl-dev udns-dev mbedtls-dev pcre-dev libev-dev libtool libffi-dev &&\
 apk --no-cache add --virtual .build-deps git tar make py-pip autoconf automake build-base linux-headers && \
 git reset --hard && pip install --upgrade pip &&\
 pip install idna requests &&\
 rm -rf ~/.cache && touch /etc/hosts.deny &&\
 apk del --purge .build-deps

CMD sed -i "s|30mkey|${KEY}|" 30m.py && python 30m.py && python -u shadowsocks/server.py -c config.json
