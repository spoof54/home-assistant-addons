FROM node:20-bullseye-slim

# Installer dépendances minimales
RUN apt-get update && \
    apt-get install -y tini git bash && \
    rm -rf /var/lib/apt/lists/*

# Dossier de travail pour n8n
ENV N8N_USER_FOLDER=/data
WORKDIR /data

# Installer n8n + plugin Home Assistant
RUN npm install -g n8n n8n-nodes-homeassistantws

# Sécurité : forcer les permissions
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Ajouter script de démarrage
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Exposer port
EXPOSE 5678

# Lancer via tini + run.sh
ENTRYPOINT ["/usr/bin/tini", "-s", "--", "/run.sh"]
