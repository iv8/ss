FROM alpine

MAINTAINER IV8<admin@30m.cloud>

COPY .git /root/shadowsocks/.git

WORKDIR /root/shadowsocks

RUN apk --no-cache add curl python python-dev libsodium-dev openssl-dev udns-dev mbedtls-dev pcre-dev libev-dev libtool libffi-dev &&\
 apk --no-cache add --virtual .build-deps git tar make py-pip autoconf automake build-base linux-headers && \
 git reset --hard && pip install --upgrade pip &&\
 pip install idna requests &&\
 rm -rf ~/.cache && touch /etc/hosts.deny &&\
 apk del --purge .build-deps

CMD python -u shadowsocks/server.py -c config.json
