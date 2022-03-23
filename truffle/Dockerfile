FROM node:14-alpine

WORKDIR /usr/src/app

RUN apk update \
    && apk add --no-cache git python3 g++ make \
    && rm -rf /var/cache/apk/* \
    && npm install \
    && npm install -g truffle@5.5.5
