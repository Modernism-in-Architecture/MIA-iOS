#!/bin/sh

echo "Running ci_post_clone.sh"

CONFIG_FILE="${CI_WORKSPACE}/Config.xcconfig"

if [ -z "$MIA_TOKEN" ]; then
  echo "Error: MIA_TOKEN environment variable is not set. Cannot generate Config.xcconfig."
  exit 1
else
  echo "Generating Config.xcconfig..."
  echo "API_TOKEN = $MIA_TOKEN" > "$CONFIG_FILE"
  echo "Config.xcconfig generated successfully."
fi