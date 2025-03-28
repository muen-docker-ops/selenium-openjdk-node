FROM selenium/node-chromium:134.0

# 安装OpenJDK 11和 node 20
USER root
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk curl ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/* \
    && rm -rf /usr/share/doc/* \
    && rm -rf /var/cache/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/tmp/* \
    && rm -rf /usr/local/src/* \
    && apt-get clean

# 设置JAVA_HOME环境变量
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# 添加JAVA_HOME到PATH
ENV PATH $JAVA_HOME/bin:$PATH
