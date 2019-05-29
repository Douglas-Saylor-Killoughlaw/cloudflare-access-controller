FROM golang:1.12 AS builder
ADD . /app
WORKDIR /app
RUN go mod download

RUN GCO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o build/cloudflare-access-controller

FROM scratch
COPY --from=builder /app/build ./
ENTRYPOINT ["./cloudflare-access-controller"]