#!/bin/bash

# XTE Wallet Build Script - React Native 0.76.1 with Android APK Build

set -e

PROJECT_ROOT="/Users/traaitt/Documents/GitHub/XTEcash-wallet"
cd "$PROJECT_ROOT"

echo "========================================"
echo "XTE Wallet - Build Script"
echo "========================================"
echo ""

# Check Node.js and npm
echo "Checking environment..."
NODE_VERSION=$(node --version)
NPM_VERSION=$(npm --version)
echo "✓ Node.js: $NODE_VERSION"
echo "✓ npm: $NPM_VERSION"
echo ""

# Install dependencies
echo "Installing npm dependencies..."
npm install --legacy-peer-deps --no-optional 2>&1 | tail -20

# Check if installation was successful
if [ -d "node_modules" ]; then
    echo "✓ Dependencies installed successfully"
else
    echo "✗ Failed to install dependencies"
    exit 1
fi

echo ""
echo "Building Android Release APK..."
echo "========================================"

# Navigate to android directory
cd "$PROJECT_ROOT/android"

# Build release APK
./gradlew clean
./gradlew assembleRelease

# Check if build was successful
if [ -f "app/build/outputs/apk/release/app-release.apk" ]; then
    APK_PATH="app/build/outputs/apk/release/app-release.apk"
    APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
    echo ""
    echo "========================================"
    echo "✓ BUILD SUCCESSFUL!"
    echo "========================================"
    echo "APK File: $APK_PATH"
    echo "APK Size: $APK_SIZE"
    echo ""
    echo "To install on device:"
    echo "  adb install -r '$APK_PATH'"
else
    echo "✗ APK build failed"
    exit 1
fi

echo ""
echo "Build completed successfully!"
echo "========================================"
