#!/bin/bash

# Namespace où se trouvent les blockdevices (souvent openebs)
NAMESPACE="openebs"

# Identifiants des blockdevices des workers
WORKERS=("worker1" "worker2")

# Attente max en secondes (optionnel)
TIMEOUT=900  # 15 minutes
INTERVAL=30
elapsed=0

echo "⏳ Attente..."

check_blockdevices_active() {
    local pending=0
    for worker in "${WORKERS[@]}"; do
        worker_pending=$(kubectl get bd -n "$NAMESPACE" --no-headers | grep "$worker" | grep -v 'Active' | wc -l)
        pending=$((pending + worker_pending))
    done
    echo "$pending"
}

# Première tentative
while true; do
    pending=$(check_blockdevices_active)

    if [ "$pending" -eq 0 ]; then
        echo "✅ Tous les BlockDevices des workers sont en état 'Active'."
        exit 0
    fi

    if [ "$elapsed" -ge "$TIMEOUT" ]; then
        echo "❌ Timeout atteint après $TIMEOUT secondes. Certains BlockDevices des workers ne sont pas actifs."
        kubectl get bd -n "$NAMESPACE"

        echo "🔁 Redémarrage des pods OpenEBS..."
        kubectl delete pods --all -n "$NAMESPACE"
        
        # Réinitialiser le timer
        elapsed=0

        echo "⏳ Nouvelle tentative après redémarrage..."
        break  # Quitte la boucle pour relancer une deuxième boucle
    fi

    sleep "$INTERVAL"
    elapsed=$((elapsed + INTERVAL))
done

# Deuxième tentative après redémarrage
echo "Deuxième tentative après redémarrage"
elapsed=0
while true; do
    pending=$(check_blockdevices_active)

    if [ "$pending" -eq 0 ]; then
        echo "✅ Tous les BlockDevices des workers sont en état 'Active' après redémarrage."
        exit 0
    fi

    if [ "$elapsed" -ge "$TIMEOUT" ]; then
        echo "❌ Timeout atteint après redémarrage. Certains BlockDevices ne sont toujours pas actifs."
        kubectl get bd -n "$NAMESPACE"
        exit 1
    fi

    sleep "$INTERVAL"
    elapsed=$((elapsed + INTERVAL))
done




# #!/bin/bash

# # Namespace où se trouvent les blockdevices (souvent openebs)
# NAMESPACE="openebs"

# # Identifiants des blockdevices des workers
# WORKERS=("worker1" "worker2")

# # Attente max en secondes (optionnel)
# TIMEOUT=900  # 15 minutes en secondes
# INTERVAL=30
# elapsed=0

# echo "⏳ Attente que tous les BlockDevices des workers passent à l'état 'Active'..."

# while true; do
#     pending=0

#     for worker in "${WORKERS[@]}"; do
#         # Vérifie si un blockdevice de ce worker est encore non-Active
#         worker_pending=$(kubectl get bd -n "$NAMESPACE" --no-headers | grep "$worker" | grep -v 'Active' | wc -l)
#         pending=$((pending + worker_pending))
#     done

#     if [ "$pending" -eq 0 ]; then
#         echo "✅ Tous les BlockDevices des workers sont en état 'Active'."
#         break
#     fi

#     if [ "$elapsed" -ge "$TIMEOUT" ]; then
#         echo "❌ Timeout atteint après $TIMEOUT secondes. Certains BlockDevices des workers ne sont pas actifs."
#         kubectl get bd -n "$NAMESPACE"
#         exit 1
#     fi

#     sleep "$INTERVAL"
#     elapsed=$((elapsed + INTERVAL))
# done


# echo "Redemarage de tous les pods"
#         kubectl delete pods --all -n openebs
