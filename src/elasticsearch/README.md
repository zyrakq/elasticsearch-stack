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

## 🔗 Integration

### Certificate Management

This service integrates with different certificate management stacks:

- **Let's Encrypt:** [`../letsencrypt-manager/README.md`](../letsencrypt-manager/README.md) - For production deployments with internet access using public SSL certificates
- **Step CA:** [`../step-ca-manager/README.md`](../step-ca-manager/README.md) - For virtual Docker networks without internet access using self-signed trusted certificate authority
