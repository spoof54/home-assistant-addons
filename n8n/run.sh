#!/usr/bin/with-contenv bashio
set -e

# Lire config.json
HOST=$(bashio::config 'host')
PROTOCOL=$(bashio::config 'protocol')
PORT=$(bashio::config 'port')
WEBHOOK_URL=$(bashio::config 'webhook_url')
BASE_API=$(bashio::config 'base_api')
BASIC_USER=$(bashio::config 'basic_auth_user')
BASIC_PASS=$(bashio::config 'basic_auth_password')

# Exporter comme variables d’environnement pour n8n
export N8N_HOST="${HOST}"
export N8N_PROTOCOL="${PROTOCOL}"
export N8N_PORT="${PORT}"
export WEBHOOK_URL="${WEBHOOK_URL}"
export N8N_ENDPOINT_REST="${BASE_API}"

# Auth basique
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER="${BASIC_USER}"
export N8N_BASIC_AUTH_PASSWORD="${BASIC_PASS}"

echo "🚀 Lancement de n8n avec la configuration suivante :"
echo "- Host: ${HOST}"
echo "- Protocol: ${PROTOCOL}"
echo "- Port: ${PORT}"
echo "- Webhook URL: ${WEBHOOK_URL}"
echo "- Base API: ${BASE_API}"

exec n8n
