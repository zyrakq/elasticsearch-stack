#!/bin/bash

# Elasticsearch Deployment Script
# Usage: ./deploy.sh [--development|--devcontainer|--production] [--keycloak]

case "$1" in
    --development|-d)
        if [ "$2" = "--keycloak" ] || [ "$2" = "-k" ]; then
            docker-compose --profile keycloak -f docker-compose.yml -f docker-compose.keycloak.yml -f docker-compose.dev.yml up -d --build
        else
            docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build
        fi
        ;;
    --devcontainer|-dc)
        if [ "$2" = "--keycloak" ] || [ "$2" = "-k" ]; then
            docker-compose --profile keycloak -f docker-compose.yml -f docker-compose.keycloak.yml -f docker-compose.devcontainer.yml up -d --build
        else
            docker-compose -f docker-compose.yml -f docker-compose.devcontainer.yml up -d --build
        fi
        ;;
    --production|-p)
        if [ "$2" = "--keycloak" ] || [ "$2" = "-k" ]; then
            docker-compose --profile keycloak -f docker-compose.yml -f docker-compose.keycloak.yml -f docker-compose.cert.yml up -d --build
        else
            docker-compose -f docker-compose.yml -f docker-compose.cert.yml up -d --build
        fi
        ;;
    --help|-h|*)
        echo "Usage: $0 [--development|--devcontainer|--production] [--keycloak]"
        echo ""
        echo "Examples:"
        echo "  $0 --development"
        echo "  $0 --development --keycloak"
        echo "  $0 --production --keycloak"
        ;;
esac