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

# Vérifier que le fichier acme.json existe et n'est pas vide dans le pod
kubectl exec -n "$NAMESPACE" "$TRAEFIK_POD" -- test -s "$ACME_PATH"
if [[ $? -ne 0 ]]; then
  echo "❌ Le fichier $ACME_PATH est introuvable ou vide dans le pod Traefik"
  exit 1
fi

# Créer le dossier temporaire
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

# Extraire acme.json depuis le pod
echo "📥 Récupération de $ACME_PATH depuis le pod..."
kubectl cp "$NAMESPACE/${TRAEFIK_POD#pod/}:$ACME_PATH" ./acme.json

# Extraire cert et key en base64 et les décoder
CERT=$(jq -r ".letsencrypt.Certificates[] | select(.domain.main == \"$DOMAIN\") | .certificate" acme.json)
KEY=$(jq -r ".letsencrypt.Certificates[] | select(.domain.main == \"$DOMAIN\") | .key" acme.json)

if [[ -z "$CERT" || -z "$KEY" ]]; then
  echo "❌ Impossible de trouver les données du certificat pour $DOMAIN dans acme.json"
  exit 1
fi

echo "$CERT" | base64 -d > fullchain.pem
echo "$KEY" | base64 -d > privkey.pem

# Créer ou mettre à jour le secret TLS dans Kubernetes
echo "🔐 Création/mise à jour du secret wildcard-tls dans le namespace $NAMESPACE..."
kubectl create secret tls wildcard-tls \
  --cert=fullchain.pem \
  --key=privkey.pem \
  -n "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

echo "✅ Secret TLS wildcard-tls disponible dans le namespace $NAMESPACE !"

# Nettoyage
rm -rf "$TMP_DIR"


