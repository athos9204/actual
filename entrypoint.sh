#!/bin/sh
set -e

# Fix volume permissions
if [ -d "/data" ]; then
    chown -R app:app /data || true
fi

exec "$@"
