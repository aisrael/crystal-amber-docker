FROM amberframework/amber:v0.6.4

WORKDIR /app

COPY shard.* /app/
RUN crystal deps

ADD . /app

CMD amber watch
