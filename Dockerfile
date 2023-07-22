# 构建阶段
FROM golang:alpine AS build
WORKDIR /app
COPY . . 
RUN go build -o /fiddler

# Linux amd64最小化运行环境
FROM alpine:latest AS runner
WORKDIR /app
COPY --from=build /fiddler /app/
ENTRYPOINT ["./fiddler"]

# Linux arm64
FROM arm64v8/alpine:latest AS runner
WORKDIR /app 
COPY --from=build /fiddler /app/
ENTRYPOINT ["./fiddler"]

# Windows amd64最小化运行环境
FROM mcr.microsoft.com/windows/nanoserver:ltsc2022 AS runner
WORKDIR /app
COPY --from=build /fiddler.exe /app/
ENTRYPOINT ["fiddler.exe"]

# Windows arm64
FROM mcr.microsoft.com/windows/nanoserver:arm64v8-ltsc2022 AS runner
WORKDIR /app
COPY --from=build /fiddler.exe /app/
ENTRYPOINT ["fiddler.exe"]
