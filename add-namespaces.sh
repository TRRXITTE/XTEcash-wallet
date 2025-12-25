#!/bin/bash
cd /Users/traaitt/Documents/GitHub/XTEcash-wallet

# Add namespace to netinfo
grep -q "namespace" node_modules/@react-native-community/netinfo/android/build.gradle || \
  sed -i '' 's/android {/android {\n    namespace "com.reactnativecommunity.netinfo"/' node_modules/@react-native-community/netinfo/android/build.gradle

# Add namespaces to other common libraries that might need them
for dir in node_modules/react-native-*/android node_modules/@*/*/android; do
  if [ -f "$dir/build.gradle" ] && [ -f "$dir/src/main/AndroidManifest.xml" ]; then
    pkg=$(grep "package=" "$dir/src/main/AndroidManifest.xml" | head -1 | sed 's/.*package="\([^"]*\)".*/\1/')
    if [ -n "$pkg" ] && ! grep -q "namespace" "$dir/build.gradle"; then
      echo "Adding namespace $pkg to $dir/build.gradle"
      sed -i '' "s/android {/android {\n    namespace \"$pkg\"/" "$dir/build.gradle"
    fi
  fi
done

echo "Done adding namespaces"
