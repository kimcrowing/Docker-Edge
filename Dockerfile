# 基于 alpine:latest 镜像
FROM alpine:latest

# 更新系统和软件包
RUN apk update && apk upgrade

# 编辑 /etc/apk/repositories 文件，把所有的仓库版本都改成 edge
RUN sed -i 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories

# 安装 librdkafka 软件包，指定架构为 aarch64
RUN apk add librdkafka --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community --arch=aarch64


