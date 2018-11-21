FROM golang:1.11.2
CMD ["go get -u github.com/kardianos/govendor"]
WORKDIR /go/src/github.com/tmpbook/jd-autobuy/vendor
COPY vendor/vendor.json .
CMD ["govendor sync"]

WORKDIR /go/src/github.com/tmpbook/jd-autobuy/
COPY autobuy.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/tmpbook/jd-autobuy/app .
CMD ["./app"]