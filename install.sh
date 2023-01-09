echo "Building the project"
xcodebuild -configuration Release 

echo "Unloading macOS OSDUI"
launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist > /dev/null 2>&1 &

echo "Loading the new OSDUI"
launchctl load -F com.m00nbek.osdui.plist > /dev/null 2>&1 &
