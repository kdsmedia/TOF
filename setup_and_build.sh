#!/bin/bash

# Exit on error
set -e

echo "--- 0. FIXING APT SOURCES ---"
# The default Codespace image may contain a broken yarn repository source
if [ -f /etc/apt/sources.list.d/yarn.list ]; then
    sudo rm /etc/apt/sources.list.d/yarn.list
fi

echo "--- 1. UPDATING AND INSTALLING SYSTEM DEPENDENCIES ---"
sudo apt-get update
sudo apt-get install -y wget unzip openjdk-8-jdk

echo "--- 2. DOWNLOADING ANDROID COMMAND-LINE TOOLS ---"
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O android-sdk.zip
mkdir -p android-sdk
unzip -o -d android-sdk android-sdk.zip
rm android-sdk.zip

echo "--- 3. SETTING UP ANDROID SDK ---"
# The zip extracts to 'cmdline-tools'. We rename it to 'latest'.
mv android-sdk/cmdline-tools android-sdk/latest
# Then we create the parent 'cmdline-tools' and move 'latest' inside it.
mkdir android-sdk/cmdline-tools
mv android-sdk/latest android-sdk/cmdline-tools/
# Set environment variables for this session
export ANDROID_HOME=$PWD/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

echo "--- ACCEPTING SDK LICENSES ---"
yes | sdkmanager --licenses

echo "--- INSTALLING SDK COMPONENTS ---"
sdkmanager "platform-tools" "platforms;android-29" "build-tools;29.0.3"

echo "--- 4. GENERATING DEBUG KEYSTORE ---"
# Ensure the .android directory exists
mkdir -p $HOME/.android
# Generate the debug keystore if it doesn't exist
if [ ! -f "$HOME/.android/debug.keystore" ]; then
    keytool -genkey -v -keystore "$HOME/.android/debug.keystore" -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Android Debug,O=Android,C=US" -storepass android -keypass android
fi

echo "--- 5. DOWNLOADING GODOT AND EXPORT TEMPLATES FROM GITHUB ---"
# Using direct links from the official GitHub releases for maximum reliability.
wget https://github.com/godotengine/godot/releases/download/2.1.6-stable/godot-2.1.6-stable-linux-headless-64bit.zip
wget https://github.com/godotengine/godot/releases/download/2.1.6-stable/Godot_v2.1.6_stable_export_templates.tpz

unzip -o godot-2.1.6-stable-linux-headless-64bit.zip
# The archive extracts a file with a different name, so we handle that.
mv godot.linux.headless.64 godot_headless
chmod +x godot_headless
rm godot-2.1.6-stable-linux-headless-64bit.zip

mkdir -p ~/.godot/templates
mv Godot_v2.1.6_stable_export_templates.tpz ~/.godot/templates/2.1.6.stable.tpz

echo "--- 6. BUILDING THE APK ---"
echo "Running Godot export command..."
./godot_headless -v --path TOF/ --export-debug "Android" "TanksOfFreedom.apk"

echo ""
echo "--- BUILD COMPLETE! ---"
echo "Your APK is named 'TanksOfFreedom.apk' and is located in the root of your project."
echo "You can download it from the VS Code file explorer on the left."
