#!/bin/bash

set -e

# 1. Allow override by environment variable or command-line parameters
if [ "$#" -gt 0 ]; then
    JAVA_CMD="$*"
else
    JAVA_CMD="${JAVA_CMD:-java -jar /app/$APPNAME-$VERSION.jar}"
fi

echo "Java Command: $JAVA_CMD"

# ====== 1. 启动你的 Java 应用（日志输出到控制台） ======
echo "Starting Java App..."
cd /app
if [ -f "/app/$APPNAME-$VERSION.jar" ];then
    sh -c "$JAVA_CMD" &
fi

# ⚠ 注意：
# 不要重定向日志到文件（否则 docker logs 看不到）
# 直接让 Java 输出到 stdout/stderr（默认就是）

# ====== 2. 启动 selenium 原来的入口脚本 ======
# 使用 exec 占据 PID 1，避免僵尸进程
echo "Starting Selenium..."
exec /opt/bin/entry_point.sh
