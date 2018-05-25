FROM crystallang/crystal
ADD note-api /note-api
ENTRYPOINT [ "/note-api" ]