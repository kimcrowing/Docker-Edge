# 基于 alpine:latest 镜像
FROM alpine:latest

# 更新系统和软件包
RUN apk update && apk upgrade

# 安装 wget 和 tar 工具
RUN apk add wget tar

# 下载 edge 浏览器的 Linux 版本
RUN wget https://go.microsoft.com/fwlink/?linkid=2158053 -O microsoft-edge-dev.tar.gz

# 解压 edge 浏览器的压缩包
RUN tar -xvf microsoft-edge-dev.tar.gz

# 删除不需要的文件
RUN rm microsoft-edge-dev.tar.gz

# 暴露端口
EXPOSE 8080

# 设置启动命令，使用 xvfb 来模拟显示器
CMD ["xvfb-run", "./microsoft-edge-dev/microsoft-edge"]
