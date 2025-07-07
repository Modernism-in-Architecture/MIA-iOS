#!/bin/sh

# This script runs after the repository is cloned in Xcode Cloud.
# Use it for any setup or dependency installation not handled by Xcode Cloud automatically.

echo "Running ci_post_clone.sh"

# Generate Config.xcconfig with API_TOKEN from MIA_TOKEN environment variable
CONFIG_FILE="${CI_WORKSPACE}/Config.xcconfig"

if [ -z "$MIA_TOKEN" ]; then
  echo "Error: MIA_TOKEN environment variable is not set. Cannot generate Config.xcconfig."
  exit 1
else
  echo "Generating Config.xcconfig..."
  echo "API_TOKEN = $MIA_TOKEN" > "$CONFIG_FILE"
  echo "Config.xcconfig generated successfully."
fi

# Example: Install CocoaPods dependencies (if you were using them)
# pod install

# Example: Install Swift Package Manager dependencies (usually handled automatically)
# swift package resolve

# Add any other setup commands here