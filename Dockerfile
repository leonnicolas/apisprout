FROM golang:1.18 as build
WORKDIR /apisprout

COPY go.sum go.mod ./
RUN go mod download

COPY . .
RUN go build ./cmd/apisprout

FROM gcr.io/distroless/base-debian11

COPY --from=build /apisprout/apisprout /usr/local/bin/

EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/apisprout"]
