FROM crystallang/crystal
WORKDIR /www/bin/cr

COPY . .

RUN shards
RUN shards build --production

CMD [ "./bin/paste" ]