#!/bin/bash
set -e

# Initialize keystore
/usr/local/bin/init-keystore.sh

# Run original entrypoint
exec /usr/local/bin/docker-entrypoint.sh "$@"