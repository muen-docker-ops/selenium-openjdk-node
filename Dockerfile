FROM selenium/node-chromium:134.0

# 安装OpenJDK 11和 node 20
USER root
RUN rm -f /etc/apt/sources.list.d/ubuntu.sources \
    && apt-get update \
    && apt-get install -y openjdk-11-jdk curl ca-certificates
    

# 设置JAVA_HOME环境变量
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# 添加JAVA_HOME到PATH
ENV PATH $JAVA_HOME/bin:$PATH
