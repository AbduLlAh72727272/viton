#!/bin/bash

# iOS Setup Script for Viton App
# Run this script on macOS to properly set up the iOS project

echo "🚀 Starting iOS setup for Viton app..."

# Navigate to iOS directory
cd ios

echo "📁 Cleaning up existing iOS build artifacts..."
# Remove existing Pods and build artifacts
rm -rf Pods
rm -rf Podfile.lock
rm -rf .symlinks
rm -rf build
rm -rf ~/Library/Developer/Xcode/DerivedData/Runner-*

echo "🧹 Cleaning Flutter project..."
cd ..
flutter clean

echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "🔧 Setting up iOS dependencies..."
cd ios

echo "📱 Installing CocoaPods dependencies..."
pod install --repo-update

echo "✅ iOS setup completed successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Open Runner.xcworkspace (NOT Runner.xcodeproj) in Xcode"
echo "2. Select your target device or simulator"
echo "3. Build and run the project (Cmd+R)"
echo ""
echo "🔍 If you encounter any issues:"
echo "- Make sure you're using Runner.xcworkspace, not Runner.xcodeproj"
echo "- Check that your iOS deployment target is 12.0 or higher"
echo "- Verify that GoogleService-Info.plist is included in the project"
echo ""
echo "🎉 Your iOS project is now ready for development!"
