FROM 1.22.5-alpine3.20 as base
RUN apk update
WORKDIR /app
COPY go.mod go.sum ./
COPY . .
RUN  go build -o app ./cmd/app

FROM alpine:3.16 as binary
COPY --from=base /app .
COPY --from=base /web ./web
EXPOSE 3000
CMD [ "./app" ]