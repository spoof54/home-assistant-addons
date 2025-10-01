# n8n Automation - Home Assistant Add-on

Ce dépôt fournit un **add-on Home Assistant** pour exécuter [n8n](https://n8n.io), l’outil d’automatisation de workflows.  
Il permet d’intégrer vos automatisations avancées directement dans Home Assistant.

---

## 🚀 Installation

1. Dans Home Assistant, ajoutez ce dépôt en tant que **dépôt personnalisé d’add-ons**.
2. Recherchez **n8n Automation** et installez-le.
3. Configurez les options dans l’UI (hôte, protocole, authentification…).
4. Lancez l’add-on, puis accédez à l’interface n8n via `http://<IP_HA>:5678`.

---

## ⚙️ Configuration

Exemple de configuration par défaut (modifiable depuis l’UI Home Assistant) :

```yaml
host: 0.0.0.0
protocol: http
port: 5678
webhook_url: "http://localhost:5678/"
base_api: "/rest"
basic_auth_user: admin
basic_auth_password: admin
```

- host : Adresse d’écoute de n8n
- protocol : http ou https
- port : Port exposé (par défaut 5678)
- webhook_url : URL publique utilisée pour les webhooks
- base_api : Endpoint REST (par défaut /rest)
- basic_auth_user : Nom d’utilisateur pour l’auth basique
- basic_auth_password : Mot de passe pour l’auth basique
---

## 📦 Contenu

Dockerfile : Définit l’image add-on n8n

config.json : Schéma et options configurables via Home Assistant

run.sh : Script d’entrée pour traduire la config en variables d’environnement

---
## 🔒 Sécurité

L’auth basique est activée par défaut (admin/admin).

Changez vos identifiants immédiatement après installation !

---
## 🌍 Ressources

[Site officiel n8n](https://n8n.io)
[Documentation Home Assistant - Add-ons](https://www.home-assistant.io/addons/)

---
## 📜 Licence

Ce projet est distribué sous licence MIT.
