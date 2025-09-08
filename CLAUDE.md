# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a standard Flutter application called "yuni_flutter_demo" - a new Flutter project with the default counter app template.

## Development Commands

### Core Flutter Commands
- `flutter run` - Run the app in debug mode on connected device/emulator
- `flutter run -d <device-id>` - Run on specific device (use `flutter devices` to list)
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app (requires macOS)
- `flutter build web` - Build for web deployment

### Development Workflow
- `flutter pub get` - Install/update dependencies
- `flutter pub upgrade` - Upgrade dependencies to latest compatible versions
- `flutter analyze` - Run static analysis (uses analysis_options.yaml configuration)
- `flutter test` - Run all tests in test/ directory
- `flutter clean` - Clean build cache and artifacts

### Hot Reload/Restart
- Press `r` during `flutter run` for hot reload
- Press `R` during `flutter run` for hot restart

## Project Structure
- `lib/` - Main Dart source code
  - `lib/main.dart` - Entry point with MyApp and MyHomePage widgets
- `test/` - Test files
- `pubspec.yaml` - Dependencies and Flutter configuration
- `analysis_options.yaml` - Lint rules and static analysis configuration
- Platform-specific folders: `android/`, `ios/`, `web/`, `macos/`, `linux/`, `windows/`

## Dependencies
- Uses `flutter_lints: ^5.0.0` for code quality
- Material Design with `cupertino_icons: ^1.0.8`
- Targets Dart SDK ^3.9.2

## Testing
Run tests with `flutter test` - currently includes widget tests in `test/widget_test.dart`.

## 通知配置

在开发过程中，Claude 应该在以下情况发送通知：

- **需要授权操作时**：当需要用户授权的操作时，发送通知提醒
- **任务完成时**：每次运行完成后，发送完成通知
- **代码修改过程中**：当认为需要通知用户进展或状态时

发送通知的方法：
```bash
./scripts/notify.sh "简短的通知内容"
```