#!/bin/bash

# Variable
NAMESPACE="apotheose"

# Récupérer le nom du pod Traefik
# | head -n 1 --> Ne garde que la première ligne correspondante (au cas où il y a plusieurs pods Traefik).
TRAEFIK_POD=$(kubectl get pods -n "$NAMESPACE" -o name | grep traefik | head -n 1)

# Si la variable est vide (aucun pod Traefik trouvé) break.
if [[ -z "$TRAEFIK_POD" ]]; then
  echo "Aucun pod Traefik trouvé dans le namespace $NAMESPACE"
  exit 1
fi

# Affiche le pod trouvé
echo "Pod Traefik trouvé : $TRAEFIK_POD"

# Supprimer le pod
echo "suppression du pod pour recharger acme.json"
kubectl delete "$TRAEFIK_POD" -n "$NAMESPACE"
echo "Pod traefik supprimé avec succès!"

echo "Attendre le redémarrage du nouveau pod traefik: 60s"
sleep 60s

# Vérifier les pods:
echo "Vérifier l'état de tous les pods avec les détails"
kubectl get pods -n "$NAMESPACE" -o wide

# Vérifier le certificat acme dans le nouveau pod traefik
echo "Vérifier le certificat acme.json"
NEW_POD=$(kubectl get pods -n "$NAMESPACE" -o name | grep traefik | head -n 1)
echo "Nouveau Pod Traefik trouvé : $NEW_POD"
kubectl exec -it -n "$NAMESPACE" "$NEW_POD" -- sh -c 'cat /letsencrypt/acme.json'


# Résumé :
# Ce script sert à vérifier qu’un pod Traefik est en cours d'exécution dans un namespace Kubernetes donné.
# Si au moins un pod Traefik est trouvé, son nom est stocké dans TRAEFIK_POD.
# Si aucun pod Traefik n’est trouvé, le script affiche un message d’erreur et s’arrête immédiatement.