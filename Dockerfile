FROM crystallang/crystal:0.26.0

ADD . /note-api-by-crystal
WORKDIR /note-api-by-crystal

RUN shards build --production

ENTRYPOINT [ "/note-api-by-crystal/bin/note-api" ]
