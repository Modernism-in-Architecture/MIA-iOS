#!/bin/sh

echo "--- Environment Variables ---"
printenv
echo "---------------------------"

echo "Running ci_post_clone.sh"

CONFIG_FILE="${CI_WORKSPACE}/Config.xcconfig"

if [ -z "$MIA_TOKEN" ]; then
  echo "Error: MIA_TOKEN environment variable is not set. Cannot generate Config.xcconfig."
  exit 1
else
  echo "Generating Config.xcconfig..."
  echo "API_TOKEN = $MIA_TOKEN" > "$CONFIG_FILE"
  if [ -f "$CONFIG_FILE" ]; then
    echo "Successfully created Config.xcconfig at ${CONFIG_FILE}"
  else
    echo "Error: Failed to create Config.xcconfig at ${CONFIG_FILE}"
    exit 1
  fi
fi