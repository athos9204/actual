#!/bin/bash
echo "[INFO] Certificate renewed on $(date)" >> /var/log/cert-renew.log

mkdir -p /app/certs/
chown app:app /app/certs/  
chmod 750 /app/certs/      


cp /etc/letsencrypt/live/t-budget.duckdns.org/fullchain.pem /app/certs/fullchain.pem
cp /etc/letsencrypt/live/t-budget.duckdns.org/privkey.pem /app/certs/privkey.pem
chown app:app /app/certs/fullchain.pem /app/certs/privkey.pem
chmod 640 /app/certs/fullchain.pem /app/certs/privkey.pem
# Reload your service if needed
systemctl reload nginx