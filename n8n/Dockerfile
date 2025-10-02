FROM node:20-bullseye-slim

# Installer dépendances nécessaires
RUN apt-get update && \
    apt-get install -y tini git jq bash && \
    rm -rf /var/lib/apt/lists/*

# Dossier de travail pour n8n
ENV N8N_USER_FOLDER=/data
WORKDIR /data

# Installer n8n + plugin Home Assistant
RUN npm install -g n8n n8n-nodes-homeassistantws

# Sécurité : forcer les permissions
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Copier rootfs dans le container
COPY rootfs/ /rootfs/
RUN chmod +x /rootfs/run.sh

# Exposer port par défaut
EXPOSE 5678

# Lancer via tini + run.sh depuis rootfs
ENTRYPOINT ["/usr/bin/tini", "-s", "--", "/rootfs/run.sh"]
