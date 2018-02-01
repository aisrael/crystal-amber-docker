FROM amberframework/amber:v0.6.4

WORKDIR /app

COPY shard.* /app/
RUN crystal deps

COPY . /app
RUN rm -rf node_modules
RUN npm install

CMD amber watch
