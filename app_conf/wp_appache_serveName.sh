#!/bin/bash

# Récupérer tous les pods dont le nom commence par "wordpress" et qui sont en statut Running
pods=$(kubectl get pods -n apotheose --selector='name=wordpress' --field-selector=status.phase=Running -o custom-columns=":metadata.name")

# Vérifier si des pods ont été trouvés
if [ -z "$pods" ]; then
  echo "Aucun pod 'wordpress' en cours d'exécution trouvé."
  exit 1
fi

# Exécuter la commande pour chaque pod
for pod in $pods; do
  echo "Exécution dans le pod $pod..."

  # Exécuter la commande kubectl exec et ajouter la directive ServerName
  kubectl exec -it "$pod" -n apotheose -- /bin/bash -c 'echo "ServerName wordpress.christ-devops.duckdns.org" >> /etc/apache2/sites-available/000-default.conf'

  # Vérification des erreurs
  if [ $? -eq 0 ]; then
    echo "Directive ServerName ajoutée avec succès dans le pod $pod."
  else
    echo "Erreur lors de l'ajout de la directive ServerName dans le pod $pod."
  fi
done
