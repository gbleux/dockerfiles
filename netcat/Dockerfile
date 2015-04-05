# VERSION           0.0.1
# DOCKER-VERSION    1.4.0

FROM gliderlabs/alpine:latest
MAINTAINER Gordon Bleux <gordon.bleux+dnc@gmail.com> (@gbleux)

RUN apk update \
    && apk add netcat-openbsd

CMD ["nc", "--help"]
