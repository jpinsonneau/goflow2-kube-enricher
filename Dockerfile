FROM golang:alpine as builder
ARG VERSION=""

RUN apk --update --no-cache add git build-base gcc

COPY src /build
WORKDIR /build

RUN go build -ldflags "-X main.version=${VERSION}" -o kube-enricher

FROM netsampler/goflow2:latest

COPY --from=builder /build/kube-enricher /

ENTRYPOINT ["./goflow2"]