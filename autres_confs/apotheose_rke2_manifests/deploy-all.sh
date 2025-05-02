#!/bin/bash

# kubectl
ls -l /var/lib/rancher/rke2/bin/kubectl
export PATH=$PATH:/var/lib/rancher/rke2/bin
echo 'export PATH=$PATH:/var/lib/rancher/rke2/bin' >> ~/.bashrc
source ~/.bashrc
kubectl version --client
sudo chmod 644 /etc/rancher/rke2/rke2.yaml
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
kubectl get nodes

# Namespace à utiliser
NAMESPACE="apotheose"

# Dossier contenant tous les fichiers YAML
MANIFESTS_DIR="./apotheose_rke2_manifests"

# Fichier kubeconfig (utile si script exécuté dans un playbook ou un conteneur)
KUBECONFIG_PATH="/etc/rancher/rke2/rke2.yaml"

echo "Vérification de l'existence du namespace '$NAMESPACE'..."
kubectl get namespace "$NAMESPACE" --kubeconfig="$KUBECONFIG_PATH" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Namespace '$NAMESPACE' non trouvé, création en cours..."
  kubectl create namespace "$NAMESPACE" --kubeconfig="$KUBECONFIG_PATH"
else
  echo "Namespace '$NAMESPACE' déjà existant."
fi

echo "Déploiement prioritaire des bases de données...et de Traefik"

# Appliquer d'abord les fichiers critiques (ex : MySQL & PostgreSQL)
PRIORITY_FILES=(
  "$MANIFESTS_DIR/Traefik-k8s-manifests.yaml"
  "$MANIFESTS_DIR/mysql-k8s-manifests.yaml"
  "$MANIFESTS_DIR/sonar_db-k8s-manifests.yaml"
  
)

for file in "${PRIORITY_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "Application prioritaire : $file"
    kubectl apply --server-side -f "$file" -n "$NAMESPACE" --kubeconfig="$KUBECONFIG_PATH"
  fi
done

echo "Déploiement du reste des manifests..."

# Puis appliquer tous les autres fichiers sauf ceux déjà faits
for manifest_file in "$MANIFESTS_DIR"/*.yaml; do
  skip=0
  for priority_file in "${PRIORITY_FILES[@]}"; do
    [[ "$manifest_file" == "$priority_file" ]] && skip=1 && break
  done

  if [ "$skip" -eq 0 ] && [ -f "$manifest_file" ]; then
    echo "Application de $manifest_file..."
    kubectl apply --server-side -f "$manifest_file" -n "$NAMESPACE" --kubeconfig="$KUBECONFIG_PATH"
  fi
done

echo "Déploiement terminé dans le namespace '$NAMESPACE'."



# echo "Déploiement des manifests dans '$MANIFESTS_DIR'..."
# 
# # Parcourir les fichiers YAML et les appliquer
# for manifest_file in "$MANIFESTS_DIR"/*.yaml; do
#   if [ -f "$manifest_file" ]; then
#     echo "Application de $manifest_file..."
#     kubectl apply --server-side -f "$manifest_file" -n "$NAMESPACE" --kubeconfig="$KUBECONFIG_PATH"
#   fi
# done
# 
# echo "✅ Déploiement terminé dans le namespace '$NAMESPACE'."

