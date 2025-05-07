#!/bin/bash

echo "Vérifier l'état des pods dans le namespace openebs"
kubectl get pods -n openebs

TIMEOUT=360
INTERVAL=30
ELAPSED_TIME=0

while true; do
    # Compter le nombre de pods qui ne sont pas complètement prêts (READY != READY)
    NOT_READY_COUNT=$(kubectl get pods -n openebs --no-headers | awk '{print $2}' | grep -vE '^[0-9]+/[0-9]+$' | wc -l)
    PARTIALLY_READY=$(kubectl get pods -n openebs --no-headers | awk '{print $2}' | awk -F'/' '$1 != $2' | wc -l)
    TOTAL_NOT_READY=$((NOT_READY_COUNT + PARTIALLY_READY))

    if [ "$TOTAL_NOT_READY" -eq 0 ]; then
        echo "✅ Tous les pods sont prêts dans openebs."
        break
    fi

    if [ "$ELAPSED_TIME" -ge "$TIMEOUT" ]; then
        echo "❌ Le temps imparti est écoulé, certains pods ne sont pas prêts."
        kubectl get pods -n openebs
        break
    fi

    echo "⏳ Attente... $ELAPSED_TIME secondes écoulées. Pods non prêts: $TOTAL_NOT_READY"
    sleep $INTERVAL
    ELAPSED_TIME=$((ELAPSED_TIME + INTERVAL))
done



# #!/bin/bash


# # Vérification si les pods sont tous prêts dans openebs
# echo "Vérifier l'état des pods dans le namespace openebs"
# kubectl get pods -n openebs

# # Attendre que les pods soient prêts ou redémarrer si ça prend trop de temps
# TIMEOUT=360  # 6 minutes en secondes
# INTERVAL=30  # Vérification toutes les 30 secondes
# ELAPSED_TIME=0

# while true; do
#     # Vérifier si tous les pods sont en état 'Ready'
#     NOT_READY_PODS=$(kubectl get pods -n openebs --field-selector=status.phase!=Running -o custom-columns=":metadata.name" | wc -l)

#     if [ "$NOT_READY_PODS" -eq 0 ]; then
#         echo "Tous les pods sont prêts dans openebs."
#         break
#     fi

#     if [ "$ELAPSED_TIME" -ge "$TIMEOUT" ]; then
#         echo "Le temps imparti est écoulé, redémarrage des pods openebs."
#         echo "Vérifier l'état actuel des pods dans le namespace openebs"
#         kubectl get pods -n openebs
#         break
#     fi

#     echo "Attente... $ELAPSED_TIME secondes écoulées."
#     sleep $INTERVAL
#     ELAPSED_TIME=$((ELAPSED_TIME + INTERVAL))
# done



# kubectl delete pods --all -n openebs
#         echo "Tous les pods dans openebs ont été redémarrés."