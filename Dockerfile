FROM alpine:3.4

MAINTAINER Sergii Nuzhdin <ipaq.lw@gmail.com>

ENV KUBE_LATEST_VERSION=v1.7.11

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip go git \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && rm -rf linux-amd64 \
 && chmod +x /usr/local/bin/kubectl

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN go get -d github.com/mayflower/docker-ls/cli/...

RUN go generate github.com/mayflower/docker-ls/lib/...

RUN go install github.com/mayflower/docker-ls/cli/...

RUN apk del --purge deps && rm /var/cache/apk/*
