# 指定多平台
FROM --platform=$TARGETPLATFORM golang:alpine AS build

# 安装兼容层
RUN apk add --no-cache libgcc libstdc++ zlib \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub 
RUN apk del alpine-baselayout-data \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk \
    && apk add glibc-2.23-r3.apk

# 下载Edge浏览器  
ARG EDGE_VERSION=97.0.1072.69
ARG EDGE_ARM64_VERSION=97.0.1072.69
RUN if [ ${TARGETPLATFORM} = "linux/amd64" ]; then \
     wget https://xxxx/edge_$EDGE_VERSION.tar.gz; \   
    elif [ ${TARGETPLATFORM} = "linux/arm64/v8" ]; then \
     wget https://xxxx/edge_$EDGE_ARM64_VERSION.tar.gz; \
    fi && tar -xzf edge_*.tar.gz

# 最小环境
FROM --platform=$TARGETPLATFORM alpine:latest  
RUN apk add --no-cache libgcc libstdc++
COPY --from=build /opt/msedge/ /opt/msedge/
EXPOSE 3000  
ENTRYPOINT ["/opt/msedge/msedge", "--app=http://0.0.0.0:3000"]
