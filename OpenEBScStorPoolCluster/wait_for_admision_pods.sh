echo "⏳ Attente que le webhook OpenEBS soit prêt..."

MAX_WAIT=130   # Timeout total en secondes
WAIT_INTERVAL=5
WAITED=0

# Boucle pour attendre que le webhook soit prêt
while true; do
  WAITED=0
  while ! kubectl get endpoints openebs-cstor-admission-server -n openebs -o jsonpath='{.subsets}' | grep -q 'addresses'; do
    echo "  → Webhook non prêt, attente de ${WAIT_INTERVAL}s..."
    sleep $WAIT_INTERVAL
    WAITED=$((WAITED + WAIT_INTERVAL))
    if [ "$WAITED" -ge "$MAX_WAIT" ]; then
      echo "❌ Timeout : le webhook OpenEBS n'est toujours pas prêt après ${MAX_WAIT}s. Redémarrage des pods d'admission OpenEBS..."
      # Redémarre les pods d'admission OpenEBS
      kubectl rollout restart deployment openebs-cstor-admission-server -n openebs
      sleep 10  # Attente de 10 secondes pour que les pods redémarrent
      WAITED=0  # Réinitialise le compteur d'attente
      continue  # Redémarre la boucle pour vérifier à nouveau
    fi
  done

  echo "✅ Webhook OpenEBS disponible."
  break  # Si le webhook est prêt, sortir de la boucle principale
done

