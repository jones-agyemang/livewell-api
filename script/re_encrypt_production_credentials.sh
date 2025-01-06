#!/bin/bash

# Set variables for production credentials and key
ENVIRONMENT="production"
CREDENTIALS_FILE="config/credentials/$ENVIRONMENT.yml.enc"
MASTER_KEY_FILE="config/credentials/$ENVIRONMENT.key"

# Check if running in a Rails project directory with production credentials
if [ ! -f "$CREDENTIALS_FILE" ]; then
  echo "Error: $CREDENTIALS_FILE does not exist. Ensure you have production credentials configured."
  exit 1
fi

# Generate a new 16-byte key
echo "Generating a new 16-byte master key for $ENVIRONMENT environment..."
NEW_KEY=$(openssl rand -hex 16)
echo "New master key generated: $NEW_KEY"

# Backup existing master key and credentials
echo "Backing up current master key and credentials..."
cp "$MASTER_KEY_FILE" "${MASTER_KEY_FILE}.bak"
cp "$CREDENTIALS_FILE" "${CREDENTIALS_FILE}.bak"
echo "Backup completed: ${MASTER_KEY_FILE}.bak, ${CREDENTIALS_FILE}.bak"

# Update production.master.key file
echo "Updating master key..."
echo "$NEW_KEY" > "$MASTER_KEY_FILE"

# Decrypt existing production credentials
echo "Decrypting existing production credentials..."
rails credentials:show --environment=$ENVIRONMENT > tmp/production_credentials.yml
if [ $? -ne 0 ]; then
  echo "Error: Failed to decrypt production credentials. Restoring from backup..."
  mv "${MASTER_KEY_FILE}.bak" "$MASTER_KEY_FILE"
  mv "${CREDENTIALS_FILE}.bak" "$CREDENTIALS_FILE"
  rm tmp/production_credentials.yml
  exit 1
fi
echo "Decrypted production credentials saved to tmp/production_credentials.yml."

# Re-encrypt production credentials
echo "Re-encrypting production credentials with the new key..."
EDITOR="cat tmp/production_credentials.yml" rails credentials:edit --environment=$ENVIRONMENT > /dev/null
if [ $? -ne 0 ]; then
  echo "Error: Failed to re-encrypt production credentials. Restoring from backup..."
  mv "${MASTER_KEY_FILE}.bak" "$MASTER_KEY_FILE"
  mv "${CREDENTIALS_FILE}.bak" "$CREDENTIALS_FILE"
  rm tmp/production_credentials.yml
  exit 1
fi

# Cleanup
echo "Cleaning up..."
rm tmp/production_credentials.yml
rm "${MASTER_KEY_FILE}.bak" "${CREDENTIALS_FILE}.bak"
echo "Old backups removed."

echo "Re-encryption complete! Your production credentials have been re-encrypted with the new master key."
