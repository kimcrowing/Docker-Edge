# 基于 alpine 镜像
FROM alpine:3.16

# 安装依赖
RUN apk add --no-cache curl tar 

# 下载 Dev 版Edge(替换为其他版本也可以)  
RUN curl -L https://packages.microsoft.com/yumrepos/edge-dev/microsoft-edge-dev-96.0.1054.57-1.x86_64.rpm -o edge.rpm

# 解包
RUN rpm2cpio edge.rpm | cpio -idmv

# 清理
RUN rm edge.rpm

# 暴露端口  
EXPOSE 8080

# 启动Edge
CMD ["./opt/microsoft/msedge-dev/msedge"]
