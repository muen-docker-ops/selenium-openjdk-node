FROM selenium/standalone-chromium:134.0

USER root

RUN rm -f /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i '/^deb http/!d' /etc/apt/sources.list && \
    # 同时移除 /lib32、/libo32、/lib64 的 diversion，避免 base-files 冲突
    dpkg-divert --remove /lib32 || true && \
    dpkg-divert --remove /libo32 || true && \
    dpkg-divert --remove /lib64 || true && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      openjdk-11-jdk \
      curl \
      ca-certificates \
      locales \
      fonts-sil-abyssinica \
      fonts-noto-core \
      fonts-noto-extra && \
    # 生成埃塞俄比亚语言环境
    sed -i '/^# *\(am_ET.UTF-8\|ti_ET.UTF-8\) UTF-8/s/^# *//' /etc/locale.gen && \
    locale-gen && \
    # 安装 Node.js 20
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    # 清理缓存
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 独立的 ENV 指令
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"