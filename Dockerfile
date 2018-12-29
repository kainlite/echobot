# Build
FROM golang:1.11.2-alpine as builder

WORKDIR /app
RUN adduser -D -g 'app' app && \
    chown -R app:app /app && \
    apk add git && apk add gcc musl-dev

ADD . /app/
RUN go get -d -v ./... && go build -o main . && chown -R app:app /app /home/app

# Run
FROM golang:1.11.2-alpine

WORKDIR /app
RUN adduser -D -g 'app' app && \
    chown -R app:app /app

COPY --from=builder --chown=app /app/health_check.sh /app/health_check.sh
COPY --from=builder --chown=app /app/main /app/main

USER app
CMD ["/app/main"]
