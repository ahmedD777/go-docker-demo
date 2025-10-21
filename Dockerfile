# Stage 1: Build the Go app
FROM golang:1.25.3-alpine AS build

WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o server .

# Stage 2: Run the built binary
FROM alpine:latest
WORKDIR /root/
COPY --from=build /app/server .
EXPOSE 8080
CMD ["./server"]
