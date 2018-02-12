FROM amberframework/amber:v0.6.4 as builder

WORKDIR /src

COPY shard.* /src/
RUN shards

COPY . /src
RUN rm -rf node_modules
RUN npm install

RUN crystal build src/hello.cr

FROM crystallang/crystal:0.24.1

RUN mkdir /app
WORKDIR /app
COPY config /app/config
COPY public /app/public
COPY --from=builder /src/node_modules /app/node_modules
COPY --from=builder /src/hello /app/

CMD ["/app/hello"]
