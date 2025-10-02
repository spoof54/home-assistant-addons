#!/usr/bin/env bash
set -e

# 📌 Fonction pour récupérer une valeur depuis options.json
get_option() {
  key="$1"
  jq -r ".\"$key\"" /data/options.json
}

# Lire les options configurées dans l'UI
PORT=$(get_option "port")                   # <-- Nouveau
WEBHOOK_URL=$(get_option "webhook_url")
BASE_API=$(get_option "base_api")
BASIC_USER=$(get_option "basic_auth_user")
BASIC_PASS=$(get_option "basic_auth_password")

# Exporter comme variables d’environnement pour n8n
export N8N_PORT="${PORT}"                    # <-- Nouveau
export WEBHOOK_URL="${WEBHOOK_URL}"
export N8N_ENDPOINT_REST="${BASE_API}"

# Auth basique
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER="${BASIC_USER}"
export N8N_BASIC_AUTH_PASSWORD="${BASIC_PASS}"

echo "🚀 Lancement de n8n avec la configuration suivante :"
echo "- Port: ${PORT}"
echo "- Webhook URL: ${WEBHOOK_URL}"
echo "- Base API: ${BASE_API}"
echo "- Basic Auth User: ${BASIC_USER}"

# Lancer n8n
exec n8n
