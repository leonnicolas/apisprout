FROM --platform=$BUILDPLATFORM golang:1.18 as build

WORKDIR /apisprout

COPY go.sum go.mod ./
RUN go mod download

COPY . .

ARG TARGETOS TARGETARCH

RUN GOARCH=$TARGETARCH GOOS=$TARGETOS CGO_ENABLED=0 go build ./cmd/apisprout

FROM gcr.io/distroless/base-debian11

COPY --from=build /apisprout/apisprout /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/apisprout"]
