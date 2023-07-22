# 指定多平台
FROM --platform=$TARGETPLATFORM golang:alpine AS build

# 安装依赖
RUN apk add --no-cache libgcc libstdc++ nss icu-libs zlib

# 下载 Edge
ARG EDGE_VERSION=97.0.1072.69
ARG EDGE_ARM64_VERSION=97.0.1072.69
RUN if [ ${TARGETPLATFORM} = "linux/amd64" ]; then \
      wget https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/4089ae40-39df-4d1a-8397-da7e281d9409/MicrosoftEdgeEnterpriseX64.${EDGE_VERSION}.tar.gz; \
    elif [ ${TARGETPLATFORM} = "linux/arm64" ]; then \
      wget https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/4089ae40-39df-4d1a-8397-da7e281d9409/MicrosoftEdgeEnterpriseARM64.${EDGE_ARM64_VERSION}.tar.gz; \
    fi && tar -xzf edge_*.tar.gz

# 最小环境
FROM --platform=$TARGETPLATFORM alpine:latest
RUN apk add --no-cache libgcc libstdc++
COPY --from=build /opt/msedge/ /opt/msedge/
EXPOSE 3000
ENTRYPOINT ["/opt/msedge/msedge", "--app=http://0.0.0.0:3000"]
