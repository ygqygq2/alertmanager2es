FROM golang:1.14-alpine AS builder

LABEL maintainer "29ygq@sina.com"

RUN go get -u github.com/ygqygq2/alertmanager2es \
  && cd $GOPATH/src/github.com/ygqygq2/alertmanager2es \
  && make

FROM alpine:3.2.2

COPY --from=builder $GOPATH/src/github.com/ygqygq2/alertmanager2es/alertmanager2es /

CMD ["/alertmanager2es", "--help"]
