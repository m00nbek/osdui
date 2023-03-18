echo "Unloading the custom OSDUI"
launchctl unload -F com.m00nbek.osdui.plist > /dev/null 2>&1 &

echo "Loading macOS OSDUI"
launchctl load -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist > /dev/null 2>&1 &
