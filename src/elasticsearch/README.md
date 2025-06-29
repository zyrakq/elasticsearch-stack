# 🔍 Elasticsearch Service

Docker-based Elasticsearch deployment with security enabled.

## ✨ Features

- 🔒 Elasticsearch with X-Pack security (configurable version)
- 🔑 Authentication with configurable password
- 🌍 Multiple environments (development, production, devcontainer)
- 🔐 SSL/TLS support via cert-manager integration
- 💾 Persistent data storage with Docker volumes

## 🚀 Deployment

```sh
# Development environment (local ports exposed)
./deploy.sh --development

# Production environment (SSL with Let's Encrypt)
./deploy.sh --production

# DevContainer environment
./deploy.sh --devcontainer

# Show help
./deploy.sh --help
```

## ⚙️ Configuration

Create `.env` file from template:

```sh
cp .env.example .env
```

Configure variables:

```sh
# Required
ELASTICSEARCH_VERSION=9.0.2
ELASTIC_PASSWORD=your_secure_password

# Required for production
VIRTUAL_HOST=elastic.yourdomain.com
LETSENCRYPT_HOST=elastic.yourdomain.com
LETSENCRYPT_EMAIL=your-email@domain.com
```

## 🌍 Environment Details

### 🛠️ Development

- **Ports:** 9200, 9300 exposed to host
- **Network:** `elk-network` (isolated)
- **SSL:** Disabled

### 🏭 Production

- **Ports:** Internal only (proxied via nginx)
- **Network:** `cert-network` + `elk-network`
- **SSL:** Automatic Let's Encrypt certificates

### 🐳 DevContainer

- **Network:** `elasticsearch-stack-workspace-network`
- **Usage:** VS Code DevContainer development

## 🔐 Keycloak Integration

Optional OIDC authentication via Keycloak.

### ⚙️ Setup Keycloak Client

1. Create client in Keycloak Admin Console:
   - **Client ID**: `elasticsearch`
   - **Client type**: `OpenID Connect`
   - **Client authentication**: `On`
   - **Valid redirect URIs**: `http://localhost:5601/api/security/oidc/callback`

2. Configure groups mapping (Keycloak 23+):
   - **Client Scopes** → **elasticsearch-dedicated** → **Mappers** → **Create**
   - **Mapper type**: `Group Membership`
   - **Name**: `groups`
   - **Token claim name**: `groups`
   - **Add to access token**: `On`

### 🔧 Keycloak Configuration

Configure variables in `.env`:

```bash
KEYCLOAK_PROTOCOL=http
KEYCLOAK_HOST=localhost
KEYCLOAK_PORT=8080
KEYCLOAK_REALM=master
KEYCLOAK_CLIENT_ID=elasticsearch
KEYCLOAK_CLIENT_SECRET=your-secret
```

### 🚀 Keycloak Deployment

```bash
./deploy.sh --development --keycloak
./deploy.sh --production --keycloak
```

## 🔗 Integration

### With cert-manager

For SSL in production, this service integrates with the cert-manager stack. See [`../cert-manager/README.md`](../cert-manager/README.md).
