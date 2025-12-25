# XTE Wallet Modernization Plan

## Executive Summary
Modernize the traaittCash wallet to XTE with React Native 0.76.1, updated app identifier (io.traaitt.osx), and new network configuration.

## Current Status
### Completed ✅
- React Native upgraded to 0.76.1
- Package.json dependencies updated
- App identifier changed to `io.traaitt.osx` in:
  - AndroidManifest.xml
  - build.gradle (applicationId)
- Config.js partially updated with XTE parameters:
  - coinName: 'XTE'
  - ticker: 'XTE'
  - addressPrefix: 1334
  - blockTargetTime: 45 seconds
  - minimumFee: 100
  - chainLaunchTimestamp: 1686748487
- Native module name changed to `xte_jni`

### Remaining Work 🔨

## Phase 1: Java Package Refactoring
**Priority: CRITICAL** - Must be done before build will work

### Tasks:
1. **Rename Java package structure** from `com.traaittcashmobile` to `io.traaitt.osx`
   - Move files from `android/app/src/main/java/com/traaittcashmobile/`
   - To: `android/app/src/main/java/io/traaitt/osx/`

2. **Update package declarations in Java files:**
   - MainApplication.java
   - MainActivity.java
   - TurtleCoinModule.java → Rename to XTEModule.java
   - TurtleCoinPackage.java → Rename to XTEPackage.java
   - All supporting classes (TransactionInput, SpendKey, KeyOutput, etc.)

3. **Update Java imports** that reference the old package

4. **Update Native Module Registration**
   - Change `TurtleCoinPackage` to `XTEPackage`
   - Update JavaScript bridge references in NativeCode.js

## Phase 2: Network Configuration Update
**Priority: HIGH** - Core functionality requirement

### Tasks:
1. **Update Config.js network settings:**
   ```javascript
   // Change from:
   this.defaultDaemon = new Daemon('daemon.xtecash.com', 14485);
   this.nodeListURL = 'http://nodes.xtecash.com/node/list';

   // To:
   this.defaultDaemon = new Daemon('main.trrxitte.com', 443, true); // SSL enabled
   this.nodeListURL = 'https://raw.githubusercontent.com/TRRXITTE/XTEnetworkserver/refs/heads/main/traaitt.json';
   ```

2. **Add XTE node list constants** in Config.js:
   ```javascript
   this.nodeList = [
     { name: 'Main Node', host: 'main.trrxitte.com', port: 443, ssl: true },
     { name: 'US East', host: 'us-east.trrxitte.com', port: 14485, ssl: false },
     { name: 'US West', host: 'us-west.trrxitte.com', port: 14485, ssl: false },
     { name: 'Europe West', host: 'eu-west.trrxitte.com', port: 14485, ssl: false },
     // ... additional nodes from JSON
   ];
   ```

3. **Implement auto-best-node selection:**
   - Add node ping/health check function
   - Measure latency to each node
   - Auto-select lowest latency node on wallet load
   - Fallback to next best if primary fails

## Phase 3: UI Updates for Network Selection
**Priority: MEDIUM** - User experience enhancement

### Tasks:
1. **Update SettingsScreen.js:**
   - Add network node selection dropdown
   - Display current node and connection status
   - Add "Test Connection" button
   - Add "Auto-Select Best Node" toggle
   - Show node latency/ping time

2. **Add Network Selection Screen** (optional):
   - Dedicated screen for advanced network settings
   - Manual node entry capability
   - Node health monitoring
   - Connection history

## Phase 4: Build System & Dependencies
**Priority: HIGH** - Required for compilation

### Tasks:
1. **Update Android build configuration:**
   - Update compileSdkVersion to 34 (Android 14)
   - Update targetSdkVersion to 34
   - Update Android Gradle Plugin to 8.1.0
   - Update Gradle wrapper to 8.4

2. **Fix Native Module Compatibility:**
   - Update NDK integration for React Native 0.76
   - Update C++ JNI bindings if needed
   - Test crypto operations (key generation, signing, etc.)

3. **Update React Navigation:**
   - Migrate from react-navigation v4 to v6
   - Update navigation structure and patterns
   - Fix deprecated APIs

4. **Install missing dependencies:**
   ```bash
   yarn install
   npx react-native link
   cd android && ./gradlew clean
   ```

## Phase 5: Code References & Branding
**Priority: LOW** - Cosmetic/reference updates

### Tasks:
1. **Update string references:**
   - Search and replace "traaittCash" → "XTE"
   - Search and replace "TurtleCoin" → "XTE"
   - Update "TCH" → "XTE"

2. **Update URLs and links:**
   - Explorer: https://explorer.xtecash.com
   - Repo: https://github.com/traaitt/XTEcash-wallet
   - Play Store: io.traaitt.osx

3. **Update branding assets:**
   - App icons (if needed)
   - Splash screens
   - Color schemes

## Phase 6: Testing & Validation
**Priority: CRITICAL** - Ensure nothing breaks

### Test Cases:
1. **Build Tests:**
   - [ ] Clean build succeeds
   - [ ] APK generates successfully
   - [ ] App installs on device

2. **Network Tests:**
   - [ ] Connects to main.trrxitte.com:443
   - [ ] Can fetch node list from GitHub
   - [ ] Auto-select best node works
   - [ ] Manual node selection works
   - [ ] Fallback to alternate nodes works

3. **Wallet Operations:**
   - [ ] Create new wallet
   - [ ] Import wallet from seed
   - [ ] Sync blockchain
   - [ ] Send transaction
   - [ ] Receive transaction
   - [ ] View transaction history

4. **Native Module Tests:**
   - [ ] Key generation works
   - [ ] Signature generation works
   - [ ] Block processing works

## Implementation Order

### Sprint 1: Critical Path (Day 1-2)
1. Refactor Java package structure
2. Update native module registration
3. Update Config.js network settings
4. Fix build system issues

### Sprint 2: Core Features (Day 3-4)
5. Implement network node selection
6. Add auto-best-node feature
7. Update React Navigation
8. Test wallet operations

### Sprint 3: Polish & Testing (Day 5-6)
9. Update branding/strings
10. Comprehensive testing
11. Bug fixes
12. Documentation updates

## Risk Mitigation

### High Risk Areas:
1. **Native Module Compatibility** - C++ JNI may need updates for RN 0.76
   - Mitigation: Test crypto operations early, have fallback to JS implementation

2. **Network Protocol Changes** - XTE daemon protocol may differ from traaittCash
   - Mitigation: Test against XTE testnet first, verify RPC compatibility

3. **Database Migration** - Existing wallet data uses TCH format
   - Mitigation: Users will create new XTE wallets (fresh start approach)

4. **SSL/HTTPS on port 443** - Different from standard RPC port 14485
   - Mitigation: Ensure Daemon class supports SSL parameter, test thoroughly

## Success Criteria
- [ ] App builds without errors
- [ ] Connects to main.trrxitte.com:443 successfully
- [ ] Can create and import XTE wallets
- [ ] Can send and receive XTE transactions
- [ ] Network node selection works
- [ ] Auto-best-node feature functional
- [ ] All tests passing
- [ ] APK size < 50MB

## Notes
- This is a complete migration from TCH to XTE (no backward compatibility)
- Users will need to create new wallets
- Old traaittCash wallets will not be supported
- Focus on Android first (iOS support later)
