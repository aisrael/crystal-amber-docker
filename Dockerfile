FROM ysbaddaden/crystal-alpine:0.24.1 as builder

RUN apk add openssl-dev yaml-dev nodejs

WORKDIR /src

COPY shard.* /src/
RUN shards

COPY . /src
RUN rm -rf node_modules
RUN npm install

RUN crystal build src/hello.cr

FROM alpine:3.7

RUN apk add --update gc openssl yaml pcre libevent libgcc

RUN mkdir /app
WORKDIR /app
COPY config /app/config
COPY public /app/public
COPY --from=builder /src/node_modules /app/node_modules
COPY --from=builder /src/hello /app/

CMD ["/app/hello"]
