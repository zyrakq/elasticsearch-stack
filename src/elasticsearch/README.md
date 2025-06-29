# Elasticsearch Service

Docker-based Elasticsearch deployment with security enabled.

## Features

- Elasticsearch with X-Pack security (configurable version)
- Authentication with configurable password
- Multiple environments (development, production, devcontainer)
- SSL/TLS support via cert-manager integration
- Persistent data storage with Docker volumes

## Deployment

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

## Configuration

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

## Environment Details

### Development

- **Ports:** 9200, 9300 exposed to host
- **Network:** `elk-network` (isolated)
- **SSL:** Disabled

### Production

- **Ports:** Internal only (proxied via nginx)
- **Network:** `cert-network` + `elk-network`
- **SSL:** Automatic Let's Encrypt certificates

### DevContainer

- **Network:** `elasticsearch-stack-workspace-network`
- **Usage:** VS Code DevContainer development

## Access

### Development

```bash
curl -u elastic:${ELASTIC_PASSWORD} http://localhost:9200
```

### Production

```sh
curl -u elastic:${ELASTIC_PASSWORD} https://elastic.yourdomain.com
```

## Management

```sh
# View logs
docker-compose logs -f elasticsearch

# Stop services
docker-compose down

# Remove data (⚠️ destructive)
docker-compose down -v
```

## Integration

### With cert-manager

For SSL in production, this service integrates with the cert-manager stack. See [`../cert-manager/README.md`](../cert-manager/README.md).

### With other services

```yaml
services:
  your-service:
    networks:
      - elk-network
    environment:
      ELASTICSEARCH_URL: http://elasticsearch:9200
      ELASTICSEARCH_USERNAME: elastic
      ELASTICSEARCH_PASSWORD: ${ELASTIC_PASSWORD}

networks:
  elk-network:
    name: elk-network
    external: true
