# 基础镜像
FROM arm64v8/debian:buster

# 设置工作目录
WORKDIR /opt/microsoft/edge

# 安装依赖
RUN apt-get update && apt-get install -y \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \ 
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    lsb-release \
    wget

# 安装 Edge ARM64
RUN wget https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/c71262f7-9fb0-4eaa-9a12-d097ce632fac/MicrosoftEdgeStableARM64.deb
RUN dpkg -i MicrosoftEdgeStableARM64.deb

# 清理
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 暴露端口
EXPOSE 8080 

# 设置启动命令
CMD ["microsoft-edge-stable", "--remote-debugging-port=8080"]
