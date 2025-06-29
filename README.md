# 🔍 Elasticsearch Stack

Docker-based Elasticsearch deployment with SSL certificate management.

## ✨ Features

- 🔒 Elasticsearch with X-Pack security (configurable version)
- 🔑 Authentication with configurable password
- 🌍 Multiple environments (development, production, devcontainer)
- 🔐 SSL/TLS support via Let's Encrypt
- 💾 Persistent data storage with Docker volumes
- 🔐 Optional Keycloak OIDC integration
- 🧩 Modular architecture with git submodules

## 🚀 Quick Start

1. **📥 Clone with submodules:**

   ```bash
   git clone --recursive <repository-url>
   cd elasticsearch-stack
   ```

2. **⚙️ Configure environment:**

   ```bash
   cd src/elasticsearch
   cp .env.example .env
   # Edit .env with your settings
   ```

3. **🚀 Deploy:**

   ```bash
   # Basic deployment
   ./deploy.sh --development  # Local development
   ./deploy.sh --production   # Production with SSL
   ./deploy.sh --devcontainer # DevContainer environment
   
   # With Keycloak OIDC integration
   ./deploy.sh --development --keycloak
   ./deploy.sh --production --keycloak
   ```

## 📁 Project Structure

```sh
src/
├── elasticsearch/    # Main Elasticsearch service
└── cert-manager/     # SSL certificate management (submodule)
```

## ⚙️ Configuration

Edit [`src/elasticsearch/.env`](src/elasticsearch/.env.example):

```sh
# Required
ELASTICSEARCH_VERSION=9.0.2
ELASTIC_PASSWORD=your_secure_password

# Required for production
VIRTUAL_HOST=elastic.yourdomain.com
LETSENCRYPT_HOST=elastic.yourdomain.com
LETSENCRYPT_EMAIL=your-email@domain.com

# Optional: Keycloak OIDC Integration
KEYCLOAK_PROTOCOL=http
KEYCLOAK_HOST=localhost
KEYCLOAK_PORT=8080
KEYCLOAK_REALM=master
KEYCLOAK_CLIENT_ID=elasticsearch
KEYCLOAK_CLIENT_SECRET=your-client-secret-here
```

## 🌐 Access

- **Development:** <http://localhost:9200>
- **Production:** <https://your-domain.com>
- **Credentials:** `elastic` / `${ELASTIC_PASSWORD}`
- **With Keycloak:** OIDC authentication via configured realm

## 🔐 Keycloak Integration

Optional OIDC authentication support:

1. **Setup Keycloak client** with OpenID Connect
2. **Configure groups mapping** for role-based access
3. **Deploy with `--keycloak` flag** to enable integration

See [`src/elasticsearch/README.md`](src/elasticsearch/README.md#-keycloak-integration) for detailed setup instructions.

## 📄 License

Dual-licensed under [MIT](LICENSE-MIT) and [Apache 2.0](LICENSE-APACHE)
