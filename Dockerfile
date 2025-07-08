FROM selenium/standalone-chromium:134.0

# 切换到 root 用户
USER root

# 修复 base-files 安装问题并安装 OpenJDK 11 和 Node.js 20
RUN rm -f /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i '/^deb http/!d' /etc/apt/sources.list && \
    dpkg-divert --remove /lib32 || true && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jdk curl ca-certificates && \
    apt-get install -y --no-install-recommends ffmpeg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean && \
    rm -rf \
    /tmp/* \
    /usr/share/doc/* \
    /var/cache/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /var/log/*

# 设置 JAVA_HOME 环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"