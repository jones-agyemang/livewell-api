#!/bin/bash

# Set variables for production credentials and key
ENVIRONMENT="production"
CREDENTIALS_FILE="config/credentials/$ENVIRONMENT.yml.enc"
MASTER_KEY_FILE="config/credentials/$ENVIRONMENT.key"

# Check if running in a Rails project directory
if [ ! -d "config" ]; then
  echo "Error: This script must be run in the root of a Rails project."
  exit 1
fi

# Backup existing credentials and master key if they exist
if [ -f "$CREDENTIALS_FILE" ] || [ -f "$MASTER_KEY_FILE" ]; then
  echo "Backing up existing credentials and master key..."
  [ -f "$CREDENTIALS_FILE" ] && mv "$CREDENTIALS_FILE" "${CREDENTIALS_FILE}.bak"
  [ -f "$MASTER_KEY_FILE" ] && mv "$MASTER_KEY_FILE" "${MASTER_KEY_FILE}.bak"
  echo "Backup completed: ${CREDENTIALS_FILE}.bak, ${MASTER_KEY_FILE}.bak"
fi

# Generate a new 16-byte master key
echo "Generating a new 16-byte master key for $ENVIRONMENT environment..."
NEW_KEY=$(openssl rand -hex 16)
echo "New master key: $NEW_KEY"

# Save the new master key to the appropriate file
echo "Saving new master key to $MASTER_KEY_FILE..."
echo "$NEW_KEY" > "$MASTER_KEY_FILE"
echo "New master key saved."

# Create new credentials for the environment
echo "Creating new credentials file for $ENVIRONMENT environment..."
EDITOR="nano" rails credentials:edit --environment=$ENVIRONMENT

if [ $? -eq 0 ]; then
  echo "New credentials created successfully."
else
  echo "Error: Failed to create credentials. Restoring from backup..."
  [ -f "${CREDENTIALS_FILE}.bak" ] && mv "${CREDENTIALS_FILE}.bak" "$CREDENTIALS_FILE"
  [ -f "${MASTER_KEY_FILE}.bak" ] && mv "${MASTER_KEY_FILE}.bak" "$MASTER_KEY_FILE"
  exit 1
fi

# Cleanup backups if no errors occurred
if [ -f "${CREDENTIALS_FILE}.bak" ] || [ -f "${MASTER_KEY_FILE}.bak" ]; then
  echo "Cleaning up backups..."
  rm -f "${CREDENTIALS_FILE}.bak" "${MASTER_KEY_FILE}.bak"
  echo "Backups removed."
fi

echo "Process complete! New production master key and credentials have been created."
