#!/bin/bash

NAMESPACE="apotheose"
DOMAIN="christ-devops.duckdns.org"
TMP_DIR="/tmp/wildcard_cert"
ACME_PATH="/letsencrypt/acme.json"

# Récupérer le nom du pod Traefik
TRAEFIK_POD=$(kubectl get pods -n "$NAMESPACE" -o name | grep traefik | head -n 1)

if [[ -z "$TRAEFIK_POD" ]]; then
  echo "❌ Aucun pod Traefik trouvé dans le namespace $NAMESPACE"
  exit 1
fi

echo "📦 Pod Traefik trouvé : $TRAEFIK_POD"

echo "suppression du pod pour recharger acme.json"
kubectl delete pods "$TRAEFIK_POD" -n "$NAMESPACE"

echo "Pod traefik supprimé avec succès!"

