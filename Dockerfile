FROM golang:1.21-alpine as build
ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOOS=linux

RUN apk add --no-cache make git

WORKDIR /go/src/github.com/tealbase/auth

# Pulling dependencies
COPY ./Makefile ./go.* ./
RUN make deps

# Building stuff
COPY . /go/src/github.com/tealbase/auth

# Make sure you change the RELEASE_VERSION value before publishing an image.
RUN RELEASE_VERSION=unspecified make build

FROM alpine:3.17
RUN adduser -D -u 1000 tealbase

RUN apk add --no-cache ca-certificates
COPY --from=build /go/src/github.com/tealbase/auth/auth /usr/local/bin/auth
COPY --from=build /go/src/github.com/tealbase/auth/migrations /usr/local/etc/auth/migrations/
RUN ln -s /usr/local/bin/auth /usr/local/bin/gotrue

ENV GOTRUE_DB_MIGRATIONS_PATH /usr/local/etc/auth/migrations

USER tealbase
CMD ["auth"]
