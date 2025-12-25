# XTE Wallet Migration - React Native 0.76.x Upgrade

## Summary of Changes

This document outlines all the changes made to migrate the wallet from traaittCash to XTE and upgrade from React Native 0.60.4 to 0.76.1.

### 1. React Native Version Upgrade

**Updated in package.json:**
- React: 16.8.6 → 18.3.1
- React Native: 0.60.4 → 0.76.1
- Metro Babel Preset: 0.55.0 → 0.77.0
- Babel: 7.5.5 → 7.23.0
- Jest: 24.8.0 → 29.7.0

**Updated dependencies:**
- @react-native-community/async-storage: 1.6.1 → 1.12.1
- @react-native-community/netinfo: 4.1.3 → 9.3.7
- @sentry/react-native: 1.2.1 → 5.18.1
- react-native-gesture-handler: 1.3.0 → 2.13.0
- react-native-svg: 9.5.3 → 14.0.0
- react-navigation: 3.11.1 → 4.4.4
- And various other package updates for compatibility

### 2. App Name Branding Migration

**Files Updated:**
- `package.json`: name changed from "traaittCashMobile" to "XTE"
- `app.json`: displayName changed from "traaittCashMobile" to "XTE"
- `android/settings.gradle`: rootProject.name changed to "XTE"

### 3. App Identifier Changes

**Android:**
- ApplicationID: com.traaittcashmobile → io.traaitt.osx
- Package name in AndroidManifest.xml: com.traaittcashmobile → io.traaitt.osx
- MainActivity class reference updated to io.traaitt.osx.MainActivity
- MainApplication class reference updated to io.traaitt.osx.MainApplication
- JNI module name: traaittCash_jni → xte_jni
- Sentry project name updated in sentry.properties
- Sentry release identifier updated in Sentry.js

**Affected Files:**
- android/app/build.gradle
- android/app/src/main/AndroidManifest.xml
- android/settings.gradle
- android/sentry.properties
- src/Sentry.js

### 4. XTE Network Configuration

**Updated in src/Config.js:**
- coinName: "traaittCash" → "XTE"
- uriPrefix: "traaittcash://" → "xte://"
- ticker: "TCH" → "XTE"
- defaultDaemon: us-east.traaittnode.com:14486 → daemon.xtecash.com:11898
- appName: "traaittCash Mobile" → "XTE Wallet"
- explorerBaseURL: "https://traaittchain.cash/?hash=" → "https://explorer.xtecash.com/?hash="
- googlePlayLink: Updated to include new app ID io.traaitt.osx
- nodeListURL: "http://cacheapi.traaittcash.com/node/list" → "http://nodes.xtecash.com/node/list"
- repoLink: Updated to "https://github.com/traaitt/XTEcash-wallet"

### 5. Breaking Changes & Considerations

1. **React Native 0.76 Migration:**
   - New architecture support required
   - Expo-based modules may need updates
   - CocoaPods version for iOS may need updating
   - Native module rebuilding recommended

2. **Java/Kotlin Requirements:**
   - Minimum Java version may have changed
   - Gradle wrapper version should be checked

3. **iOS Considerations:**
   - Pod version compatibility
   - Xcode version requirements
   - Swift version requirements

## Build Instructions

### Prerequisites
- Node.js v24.10.0 or compatible
- npm 11.6.1 or compatible
- Android SDK (for APK building)
- Java/Gradle configured

### Installation Steps

```bash
cd /Users/traaitt/Documents/GitHub/XTEcash-wallet

# Install dependencies with legacy peer deps for compatibility
npm install --legacy-peer-deps

# For iOS (if needed)
cd ios
pod install
cd ..

# Start Metro bundler
npm start

# In another terminal, build Android APK
cd android
./gradlew assembleRelease
```

### Building Android APK

```bash
cd /Users/traaitt/Documents/GitHub/XTEcash-wallet/android
./gradlew assembleRelease
# APK will be at: app/build/outputs/apk/release/app-release.apk
```

### Testing

- Test wallet creation with new XTE network
- Verify daemon connection at daemon.xtecash.com:11898
- Test transaction functionality
- Verify QR code scanning with new URI scheme (xte://)
- Test all currency conversion features

## Files Modified

1. ✅ package.json
2. ✅ app.json
3. ✅ android/settings.gradle
4. ✅ android/app/build.gradle
5. ✅ android/app/src/main/AndroidManifest.xml
6. ✅ android/sentry.properties
7. ✅ src/Config.js
8. ✅ src/Sentry.js

## Next Steps

1. ⏳ Complete npm install
2. Build Android APK
3. Test APK installation and functionality
4. iOS build setup and testing
5. App store submission preparation

## Notes

- The wallet-backend dependency remains at v5.1.0 (unchanged)
- Crypto operations remain the same
- Address prefix (925524) remains unchanged
- Standard and integrated address lengths remain unchanged
