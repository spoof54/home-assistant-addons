#!/usr/bin/env bash
set -e

# 📌 Fonction pour récupérer une valeur depuis options.json
get_option() {
  key="$1"
  jq -r ".\"$key\"" /data/options.json
}

# Lire les options configurées dans l'UI
PORT=$(get_option "port")
WEBHOOK_URL=$(get_option "webhook_url")
BASE_API=$(get_option "base_api")
BASIC_USER=$(get_option "basic_auth_user")
BASIC_PASS=$(get_option "basic_auth_password")

# Récupérer l'IP de l'hôte HA (gateway Docker)
HA_IP=$(ip route | awk '/default/ {print $3}')

# Si webhook_url est vide → construire par défaut http://IP_HA:PORT
if [ -z "$WEBHOOK_URL" ] || [ "$WEBHOOK_URL" = "null" ]; then
  WEBHOOK_URL="http://${HA_IP}:${PORT}"
fi

# Exporter comme variables d’environnement pour n8n
export N8N_HOST="0.0.0.0"
export N8N_PROTOCOL="http"
export N8N_PORT="${PORT}"
export N8N_ENDPOINT_REST="${BASE_API}"
export N8N_EDITOR_BASE_URL="${WEBHOOK_URL}"
export N8N_WEBHOOK_URL="${WEBHOOK_URL}"
export N8N_CORS_ALLOW_ORIGIN="*"

# Auth basique
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER="${BASIC_USER}"
export N8N_BASIC_AUTH_PASSWORD="${BASIC_PASS}"

echo "🚀 Lancement de n8n avec la configuration suivante :"
echo "- Internal Port: ${PORT}"
echo "- Webhook URL: ${WEBHOOK_URL}"
echo "- Base API: ${BASE_API}"
echo "- Basic Auth User: ${BASIC_USER}"

# Lancer n8n
exec n8n
