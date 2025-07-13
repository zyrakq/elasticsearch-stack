# 🔍 Elasticsearch Stack

Docker-based Elasticsearch deployment with flexible certificate management options.

## 📦 Components

### Core Services

- **[Elasticsearch](src/elasticsearch/README.md)** - Main Elasticsearch service with X-Pack security, authentication, and multiple deployment environments

### Certificate Management

### 🌐 [Let's Encrypt Manager](src/letsencrypt-manager/README.md)

Automatic SSL certificate generation and renewal using Let's Encrypt for production deployments with internet access.

### 🔒 [Step CA Manager](src/step-ca-manager/README.md)

Self-signed trusted certificate authority for virtual Docker networks without internet access. Automatically manages and distributes CA certificates within isolated environments.

## 🚀 Quick Start

Each component has its own README with detailed setup instructions. Choose the certificate management solution that fits your deployment scenario.

## 📄 License

This project is dual-licensed under:

- [Apache License 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)
