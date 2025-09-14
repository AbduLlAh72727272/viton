# iOS Troubleshooting Guide for Viton App

## 🚨 Common Issues and Solutions

### 1. **"Failed to load container" Error**
**Problem**: Xcode shows "Failed to load container for document at url: file:///path/to/Runner.xcodeproj"

**Solution**: 
- ✅ **FIXED**: The Xcode project file has been corrected with proper ID references
- Always open `Runner.xcworkspace` (NOT `Runner.xcodeproj`)
- If still having issues, delete `ios/Runner.xcodeproj/project.xcworkspace` and let Xcode regenerate it

### 2. **Firebase Configuration Error**
**Problem**: "FirebaseApp.configure() could not find a valid GoogleService-Info.plist"

**Solution**:
- ✅ **FIXED**: GoogleService-Info.plist is now properly included in the Xcode project
- Verify the file exists at `ios/Runner/GoogleService-Info.plist`
- Make sure it's added to the Xcode project (should show in Project Navigator)

### 3. **CocoaPods Issues**
**Problem**: "undefined method 'map' for nil" or other CocoaPods errors

**Solution**:
- ✅ **FIXED**: Podfile has been cleaned and simplified
- Run the setup script: `bash ios_setup.sh`
- Or manually:
  ```bash
  cd ios
  rm -rf Pods Podfile.lock .symlinks
  pod install --repo-update
  ```

### 4. **Build Failures**
**Problem**: Various build errors during compilation

**Solutions**:
- Clean build folder: `Product > Clean Build Folder` in Xcode
- Reset simulator: `Device > Erase All Content and Settings`
- Check iOS deployment target (should be 12.0+)
- Verify all dependencies are properly installed

### 5. **Permission Issues**
**Problem**: App crashes when accessing camera or photo library

**Solution**:
- ✅ **FIXED**: All necessary permissions are configured in Info.plist
- Permissions include: Camera, Photo Library, Network access

## 🔧 Setup Instructions

### For macOS Users:
1. **Enable Developer Mode** (if on Windows, then switch to macOS)
2. **Run the setup script**:
   ```bash
   chmod +x ios_setup.sh
   ./ios_setup.sh
   ```
3. **Open in Xcode**:
   - Open `ios/Runner.xcworkspace` (NOT Runner.xcodeproj)
   - Select your target device
   - Build and run (Cmd+R)

### For Windows Users:
- The iOS project is now properly configured
- When you switch to macOS, run the setup script
- All configuration files are ready

## 📱 Testing Checklist

Before testing, verify:
- [ ] GoogleService-Info.plist is in the project
- [ ] All permissions are granted in iOS Settings
- [ ] Firebase project is properly configured
- [ ] App builds without errors
- [ ] No CocoaPods warnings

## 🆘 Still Having Issues?

If you're still experiencing problems:

1. **Check Xcode version**: Ensure you're using Xcode 14.0 or later
2. **iOS Simulator**: Try a different simulator or reset the current one
3. **Clean everything**: 
   ```bash
   flutter clean
   cd ios && rm -rf Pods Podfile.lock .symlinks build
   pod install --repo-update
   ```
4. **Check Firebase Console**: Verify your Firebase project settings
5. **Bundle ID**: Ensure bundle ID matches in Firebase and Xcode

## 📞 Support

The iOS project is now properly configured with:
- ✅ Fixed Xcode project file
- ✅ Proper Firebase integration
- ✅ Clean CocoaPods setup
- ✅ All necessary permissions
- ✅ Error handling in AppDelegate

Your iOS app should now build and run successfully!
