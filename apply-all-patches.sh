#!/bin/bash
# Apply all necessary patches to node_modules

echo "Applying all patches..."

# Fix AndroidX imports in tcp/udp
find node_modules/react-native-tcp/android -name "*.java" -exec sed -i '' 's/android\.support\.annotation/androidx.annotation/g' {} \; 2>/dev/null
find node_modules/react-native-udp/android -name "*.java" -exec sed -i '' 's/android\.support\.annotation/androidx.annotation/g' {} \; 2>/dev/null

# Fix deprecated compile syntax
sed -i '' 's/compile /implementation /g' node_modules/react-native-tcp/android/build.gradle 2>/dev/null
sed -i '' 's/compile(/implementation(/g' node_modules/react-native-tcp/android/build.gradle 2>/dev/null
sed -i '' 's/compile /implementation /g' node_modules/react-native-udp/android/build.gradle 2>/dev/null
sed -i '' 's/compile(/implementation(/g' node_modules/react-native-udp/android/build.gradle 2>/dev/null

# Fix fingerprint scanner JitPack dependency
sed -i '' 's/com\.wei\.android\.lib:fingerprintidentify/com.github.uccmawei:FingerprintIdentify/' node_modules/react-native-fingerprint-scanner/android/build.gradle 2>/dev/null

# Add onTimeout to background-fetch
if ! grep -q "onTimeout" node_modules/react-native-background-fetch/android/src/main/java/com/transistorsoft/rnbackgroundfetch/RNBackgroundFetchModule.java 2>/dev/null; then
    sed -i '' '/public void onFetch(String taskId) {/a\
            }@Override public void onTimeout(String taskId) {@                // Timeout event@            }@' node_modules/react-native-background-fetch/android/src/main/java/com/transistorsoft/rnbackgroundfetch/RNBackgroundFetchModule.java 2>/dev/null
    # Fix the @ placeholders
    sed -i '' 's/@/\
/g' node_modules/react-native-background-fetch/android/src/main/java/com/transistorsoft/rnbackgroundfetch/RNBackgroundFetchModule.java 2>/dev/null
fi

echo "Patches applied!"
