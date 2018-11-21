FROM golang:1.11.2
WORKDIR /go/src/github.com/tmpbook/jd-autobuy/
COPY * .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/tmpbook/jd-autobuy/app .
CMD ["./app"]