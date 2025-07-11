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
# Local development with port forwarding
./deploy.sh --forwarding

# Production with Let's Encrypt certificates
./deploy.sh --letsencrypt

# Virtual network with Step CA certificates
./deploy.sh --step-ca

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

### 🛠️ Forwarding (Local Development)

- **Ports:** 9200, 9300 exposed to host
- **Network:** `elk-network` (isolated)
- **SSL:** Disabled

### 🔐 Let's Encrypt (Production)

- **Ports:** Internal only (proxied via nginx)
- **Network:** `letsencrypt-network` + `elk-network`
- **SSL:** Automatic Let's Encrypt certificates

### 🏢 Step CA (Virtual Network)

- **Ports:** Internal only (proxied via nginx)
- **Network:** `step-ca-network` + `elk-network`
- **SSL:** Step CA managed certificates

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
./deploy.sh --forwarding --keycloak
./deploy.sh --letsencrypt --keycloak
./deploy.sh --step-ca --keycloak
```

## 🔗 Integration

### Certificate Management

This service integrates with different certificate management stacks:

- **Let's Encrypt:** [`../letsencrypt-manager/README.md`](../letsencrypt-manager/README.md) - For production deployments with internet access using public SSL certificates
- **Step CA:** [`../step-ca-manager/README.md`](../step-ca-manager/README.md) - For virtual Docker networks without internet access using self-signed trusted certificate authority
