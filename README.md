# Elasticsearch Stack

Docker-based Elasticsearch deployment with SSL certificate management.

## Features

- Elasticsearch with security enabled (configurable version)
- Multiple environments (development, production, devcontainer)
- SSL certificates via Let's Encrypt
- Modular architecture with git submodules

## Quick Start

1. **Clone with submodules:**

   ```bash
   git clone --recursive <repository-url>
   cd elasticsearch-stack
   ```

2. **Configure environment:**

   ```bash
   cd src/elasticsearch
   cp .env.example .env
   # Edit .env with your settings
   ```

3. **Deploy:**

   ```bash
   ./deploy.sh --development  # Local development
   ./deploy.sh --production   # Production with SSL
   ```

## Project Structure

```sh
src/
├── elasticsearch/    # Main Elasticsearch service
└── cert-manager/     # SSL certificate management (submodule)
```

## Configuration

Edit [`src/elasticsearch/.env`](src/elasticsearch/.env.example):

```sh
ELASTICSEARCH_VERSION=9.0.2
ELASTIC_PASSWORD=your_secure_password

# For production
VIRTUAL_HOST=elastic.yourdomain.com
LETSENCRYPT_HOST=elastic.yourdomain.com
LETSENCRYPT_EMAIL=your-email@domain.com
```

## Access

- **Development:** <http://localhost:9200>
- **Production:** <https://your-domain.com>
- **Credentials:** `elastic` / `${ELASTIC_PASSWORD}`

## License

Dual-licensed under [MIT](LICENSE-MIT) and [Apache 2.0](LICENSE-APACHE)
