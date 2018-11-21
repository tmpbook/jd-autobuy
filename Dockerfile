FROM golang:1.11.2 as ci
WORKDIR /go/src/jd-autobuy/

COPY vendor ./vendor
COPY core ./core
COPY autobuy.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
WORKDIR /root/
COPY --from=ci /go/src/jd-autobuy/app .
CMD ["./app"]