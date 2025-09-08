#!/bin/bash

# 通知脚本 - 发送消息到 ntfy.sh/hello-vibe-coding
# 使用方法: ./scripts/notify.sh "消息内容"

if [ -z "$1" ]; then
    echo "使用方法: $0 \"消息内容\""
    exit 1
fi

MESSAGE="$1"

curl -d "$MESSAGE" ntfy.sh/hello-vibe-coding

if [ $? -eq 0 ]; then
    echo "✅ 通知发送成功: $MESSAGE"
else
    echo "❌ 通知发送失败"
fi