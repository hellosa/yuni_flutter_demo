#!/bin/bash

# TestFlight 构建和上传脚本
# 使用方法: ./scripts/build_testflight.sh
#
# 需要设置的环境变量 (可以在 .env 文件中配置):
# - API_KEY_ID: App Store Connect API Key ID
# - API_ISSUER_ID: App Store Connect API Issuer ID
# - API_PRIVATE_KEY_PATH: App Store Connect API 私钥文件路径 (.p8 文件)

set -e  # 出错时立即停止

# 加载 .env 文件 (如果存在)
if [ -f .env ]; then
    echo "📄 加载 .env 文件..."
    export $(grep -v '^#' .env | xargs)
fi

# 检查必需的环境变量
if [ -z "$API_KEY_ID" ] || [ -z "$API_ISSUER_ID" ] || [ -z "$API_PRIVATE_KEY_PATH" ]; then
    echo "❌ 缺少必需的环境变量:"
    echo "   API_KEY_ID: $API_KEY_ID"
    echo "   API_ISSUER_ID: $API_ISSUER_ID"
    echo "   API_PRIVATE_KEY_PATH: $API_PRIVATE_KEY_PATH"
    echo ""
    echo "请设置这些环境变量后再运行脚本"
    exit 1
fi

echo "🚀 开始 TestFlight 构建流程..."

# 发送开始通知
./scripts/notify.sh "🚀 TestFlight 构建开始"

# 1. 清理构建缓存
echo "🧹 清理构建缓存..."
flutter clean

# 2. 获取依赖
echo "📦 获取依赖..."
flutter pub get

# 3. 代码分析
echo "🔍 执行代码分析..."
flutter analyze
if [ $? -ne 0 ]; then
    ./scripts/notify.sh "❌ 代码分析失败"
    exit 1
fi

# 4. 运行测试
echo "🧪 运行测试..."
flutter test
if [ $? -ne 0 ]; then
    ./scripts/notify.sh "❌ 测试失败"
    exit 1
fi

# 5. 构建 iOS 应用
echo "📱 构建 iOS 应用..."
flutter build ios --release --no-codesign

# 6. 使用 Xcode 构建和上传到 TestFlight
echo "📤 使用 Xcode 构建和上传到 TestFlight..."
cd ios

# 构建并上传到 TestFlight
xcodebuild -workspace Runner.xcworkspace \
           -scheme Runner \
           -configuration Release \
           -destination generic/platform=iOS \
           -archivePath build/Runner.xcarchive \
           archive

# 导出 IPA
xcodebuild -exportArchive \
           -archivePath build/Runner.xcarchive \
           -exportPath build/ \
           -exportOptionsPlist ExportOptions.plist

# 上传到 App Store Connect (使用 App Store Connect API)
xcrun altool --upload-app \
             --type ios \
             --file build/Runner.ipa \
             --apiKey "$API_KEY_ID" \
             --apiIssuer "$API_ISSUER_ID"

cd ..

# 7. 完成通知
echo "✅ TestFlight 构建和上传完成!"
./scripts/notify.sh "✅ TestFlight 构建和上传完成"

echo ""
echo "📋 后续步骤:"
echo "1. 前往 App Store Connect 查看构建状态"
echo "2. 等待处理完成后添加测试人员"
echo "3. 发送测试邀请"
echo ""
echo "💡 首次使用需要:"
echo "1. 在 App Store Connect 创建 API Key"
echo "2. 下载 .p8 私钥文件"
echo "3. 设置环境变量 API_KEY_ID、API_ISSUER_ID、API_PRIVATE_KEY_PATH"