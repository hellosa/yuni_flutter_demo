#!/bin/bash

# TestFlight 构建和上传脚本
# 使用方法: ./scripts/build_testflight.sh
#
# 需要：
# - Xcode 已登录 Apple Developer 账户
# - 自动签名已配置
# - Team ID: W5W85Z7TLP

set -e  # 出错时立即停止

# 加载 .env 文件 (如果存在，用于其他配置)
if [ -f .env ]; then
    echo "📄 加载 .env 文件..."
    export $(grep -v '^#' .env | xargs)
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

# 先清理 Xcode 构建缓存
rm -rf build/

# 构建并上传到 TestFlight，指定开发团队
xcodebuild -workspace Runner.xcworkspace \
           -scheme Runner \
           -configuration Release \
           -destination generic/platform=iOS \
           -archivePath build/Runner.xcarchive \
           DEVELOPMENT_TEAM=W5W85Z7TLP \
           CODE_SIGN_STYLE=Automatic \
           archive

# 导出并上传到 App Store Connect（自动更新配置文件）
echo "📤 导出并上传到 App Store Connect..."

# 检查是否有 API Key 配置（用于 CI/CD）
if [ ! -z "$API_KEY_ID" ] && [ ! -z "$API_ISSUER_ID" ]; then
    echo "🔑 使用 API Key 认证..."
    xcodebuild -exportArchive \
               -archivePath build/Runner.xcarchive \
               -exportPath build/ \
               -exportOptionsPlist ExportOptions.plist \
               -allowProvisioningUpdates \
               -authenticationKeyPath "$API_PRIVATE_KEY_PATH" \
               -authenticationKeyID "$API_KEY_ID" \
               -authenticationKeyIssuerID "$API_ISSUER_ID"
else
    echo "🔑 使用 Xcode 账户认证..."
    xcodebuild -exportArchive \
               -archivePath build/Runner.xcarchive \
               -exportPath build/ \
               -exportOptionsPlist ExportOptions.plist \
               -allowProvisioningUpdates
fi

# 注意：由于 ExportOptions.plist 中设置了 destination: upload
# xcodebuild 会自动上传到 App Store Connect，无需额外步骤

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
echo "💡 提示:"
echo "- 脚本使用 Xcode 的自动签名功能"
echo "- 确保 Xcode 已登录 Apple Developer 账户"
echo "- 使用 -allowProvisioningUpdates 自动管理配置文件"