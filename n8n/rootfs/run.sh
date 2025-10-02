#!/usr/bin/env bash
set -e

get_option() {
  key="$1"
  jq -r ".\"$key\"" /data/options.json
}

PORT=$(get_option "port")
CUSTOM_WEBHOOK=$(get_option "webhook_url")
BASE_API=$(get_option "base_api")
BASIC_USER=$(get_option "basic_auth_user")
BASIC_PASS=$(get_option "basic_auth_password")

# Defaults
export N8N_HOST="0.0.0.0"
export N8N_PROTOCOL="http"
export N8N_PORT="${PORT:-5678}"
export N8N_ENDPOINT_REST="${BASE_API}"
export N8N_CORS_ALLOW_ORIGIN="*"

# Webhook URL handling
if [ -n "$CUSTOM_WEBHOOK" ] && [ "$CUSTOM_WEBHOOK" != "null" ]; then
  export WEBHOOK_URL="$CUSTOM_WEBHOOK"
else
  # fallback → utilise IP locale HA
  LOCAL_IP=$(hostname -i | awk '{print $1}')
  export WEBHOOK_URL="http://${LOCAL_IP}:${N8N_PORT}/"
fi

# Auth
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER="${BASIC_USER}"
export N8N_BASIC_AUTH_PASSWORD="${BASIC_PASS}"

echo "🚀 Lancement de n8n avec la configuration suivante :"
echo "- Internal Port: ${N8N_PORT}"
echo "- Webhook URL: ${WEBHOOK_URL}"
echo "- Base API: ${BASE_API}"
echo "- Basic Auth User: ${BASIC_USER}"

exec n8n
