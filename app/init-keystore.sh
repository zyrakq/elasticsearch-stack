#!/bin/bash
set -e

# Check that KEYCLOAK_CLIENT_SECRET is set
if [ -z "$KEYCLOAK_CLIENT_SECRET" ]; then
    echo "ERROR: KEYCLOAK_CLIENT_SECRET environment variable is required"
    exit 1
fi

# Create keystore if it doesn't exist
if [ ! -f /usr/share/elasticsearch/config/elasticsearch.keystore ]; then
    echo "Creating Elasticsearch keystore..."
    /usr/share/elasticsearch/bin/elasticsearch-keystore create
fi

# Add client secret to keystore (with force overwrite)
echo "Adding OIDC client secret to keystore..."
echo "$KEYCLOAK_CLIENT_SECRET" | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin --force xpack.security.authc.realms.oidc.oidc1.rp.client_secret

# Set proper file permissions
chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.keystore
chmod 660 /usr/share/elasticsearch/config/elasticsearch.keystore

echo "Keystore initialized successfully"