#!/usr/bin/env bash
set -e

# 📌 Fonction pour récupérer une valeur depuis options.json
get_option() {
  key="$1"
  jq -r ".\"$key\"" /data/options.json
}

# 📌 Récupération des options depuis l'UI
PORT=$(get_option "port")
WEBHOOK_URL=$(get_option "webhook_url")
BASE_API=$(get_option "base_api")
BASIC_USER=$(get_option "basic_auth_user")
BASIC_PASS=$(get_option "basic_auth_password")

# 📌 Définir le port par défaut si vide
if [ -z "$PORT" ] || [ "$PORT" = "null" ]; then
    PORT=5678
fi

# 📌 Récupérer automatiquement l'IP de Home Assistant
HA_IP=$(hostname -I | awk '{print $1}')

# 📌 Définir le webhook par défaut si vide
if [ -z "$WEBHOOK_URL" ] || [ "$WEBHOOK_URL" = "null" ]; then
    WEBHOOK_URL="http://${HA_IP}:${PORT}"
fi

# 📌 Export des variables d'environnement pour n8n
export N8N_HOST="0.0.0.0"
export N8N_PROTOCOL="http"
export N8N_PORT="${PORT}"
export N8N_ENDPOINT_REST="${BASE_API}"
export WEBHOOK_URL="${WEBHOOK_URL}"
export N8N_CORS_ALLOW_ORIGIN="*"

# 📌 Auth basique
export N8N_BASIC_AUTH_ACTIVE=true
export N8N_BASIC_AUTH_USER="${BASIC_USER}"
export N8N_BASIC_AUTH_PASSWORD="${BASIC_PASS}"

# 📌 Task Broker sur PORT + 1 pour éviter conflit
TASK_BROKER_PORT=$((PORT + 1))

# 📌 Recommandations pour éviter les dépréciations
export DB_SQLITE_POOL_SIZE=1
export N8N_RUNNERS_ENABLED=true
export N8N_BLOCK_ENV_ACCESS_IN_NODE=false
export N8N_GIT_NODE_DISABLE_BARE_REPOS=true

echo "🚀 Lancement de n8n avec la configuration suivante :"
echo "- Internal Port: ${PORT}"
echo "- Task Broker Port: ${TASK_BROKER_PORT}"
echo "- Webhook URL: ${WEBHOOK_URL}"
echo "- Base API: ${BASE_API}"
echo "- Basic Auth User: ${BASIC_USER}"
echo "- Host: ${N8N_HOST}"

# 📌 Lancement de n8n en spécifiant le port et le Task Broker
exec n8n start --port $PORT --tunnel-port $TASK_BROKER_PORT
