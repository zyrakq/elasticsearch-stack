#!/bin/bash

# Elasticsearch Deployment Script
# Usage: ./deploy.sh [--forwarding|--devcontainer|--letsencrypt|--step-ca] [--keycloak]

case "$1" in
    --forwarding|-f)
        if [ "$2" = "--keycloak" ] || [ "$2" = "-k" ]; then
            docker-compose --profile keycloak -f docker-compose.yml -f docker-compose.keycloak.yml -f docker-compose.forwarding.yml up -d --build
        else
            docker-compose -f docker-compose.yml -f docker-compose.forwarding.yml up -d --build
        fi
        ;;
    --devcontainer|-dc)
        if [ "$2" = "--keycloak" ] || [ "$2" = "-k" ]; then
            docker-compose --profile keycloak -f docker-compose.yml -f docker-compose.keycloak.yml -f docker-compose.devcontainer.yml up -d --build
        else
            docker-compose -f docker-compose.yml -f docker-compose.devcontainer.yml up -d --build
        fi
        ;;
    --letsencrypt|-le)
        if [ "$2" = "--keycloak" ] || [ "$2" = "-k" ]; then
            docker-compose --profile keycloak -f docker-compose.yml -f docker-compose.keycloak.yml -f docker-compose.letsencrypt.yml up -d --build
        else
            docker-compose -f docker-compose.yml -f docker-compose.letsencrypt.yml up -d --build
        fi
        ;;
    --step-ca|-sc)
        if [ "$2" = "--keycloak" ] || [ "$2" = "-k" ]; then
            docker-compose --profile keycloak -f docker-compose.yml -f docker-compose.keycloak.yml -f docker-compose.step-ca.yml up -d --build
        else
            docker-compose -f docker-compose.yml -f docker-compose.step-ca.yml up -d --build
        fi
        ;;
    --help|-h|*)
        echo "Usage: $0 [--forwarding|--devcontainer|--letsencrypt|--step-ca] [--keycloak]"
        echo ""
        echo "Certificate Management Options:"
        echo "  --forwarding    Local development with port forwarding"
        echo "  --letsencrypt   Production with Let's Encrypt certificates"
        echo "  --step-ca       Virtual network with Step CA certificates"
        echo "  --devcontainer  DevContainer environment"
        echo ""
        echo "Examples:"
        echo "  $0 --forwarding"
        echo "  $0 --forwarding --keycloak"
        echo "  $0 --letsencrypt --keycloak"
        echo "  $0 --step-ca"
        ;;
esac