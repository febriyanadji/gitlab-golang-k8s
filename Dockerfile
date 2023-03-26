FROM golang:1.19.5-alpine3.16 AS builder

# RUN apk add --no-cache build-base git openssh-client

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download
COPY . .

RUN CGO_ENABLED=0 go build -o /out/app

FROM alpine:3.16

COPY --from=builder /out/app .

ENTRYPOINT ["./app", "serve"]