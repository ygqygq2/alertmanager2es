FROM golang:1.14-alpine AS builder

LABEL maintainer "29ygq@sina.com"

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go build -v ./...

FROM alpine:3.12.0

RUN apk add -U openssl curl tar gzip bash ca-certificates git bash bash-doc bash-completion xmlstarlet tzdata \                                                                                        
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" > /etc/timezone \
  && rm -rf /var/cache/apk/* \
  && /bin/bash

COPY --from=builder /go/src/app/app /alertmanager2es
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
