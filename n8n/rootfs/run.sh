#!/usr/bin/env bash
set -e

# 📌 Fonction pour récupérer une valeur depuis config.json
get_config() {
  key="$1"
  jq -r ".options.\"$key\"" /data/config.json
}

# Lire les options configurées dans l'UI
WEBHOOK_URL=$(get_config "webhook_url")
BASE_API=$(get_config "base_api")
BASIC_USER=$(get_config "basic_auth_user")
BASIC_PASS=$(get_config "basic_auth_password")

# Exporter comme variables d’environnement pour n8n
export WEBHOOK_URL="${WEBHOOK_URL}"
export N8N_ENDPOINT_REST="${BASE_API}"

# Auth basique
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER="${BASIC_USER}"
export N8N_BASIC_AUTH_PASSWORD="${BASIC_PASS}"

echo "🚀 Lancement de n8n avec la configuration suivante :"
echo "- Webhook URL: ${WEBHOOK_URL}"
echo "- Base API: ${BASE_API}"
echo "- Basic Auth User: ${BASIC_USER}"

# Lancer n8n
exec n8n
