#!/bin/sh

# Vérifie si acme.json existe, sinon le crée
if [ ! -f "/letsencrypt/acme.json" ]; then
    touch /letsencrypt/acme.json
fi

# Applique les permissions nécessaires
chmod 600 /letsencrypt/acme.json

# Lance Traefik avec les arguments fournis
exec traefik "$@"
