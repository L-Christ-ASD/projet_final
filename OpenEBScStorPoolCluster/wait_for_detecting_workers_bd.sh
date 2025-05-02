#!/bin/bash



# Namespace où se trouvent les blockdevices (souvent openebs)
NAMESPACE="openebs"

# Identifiants des workers
WORKERS=("worker1" "worker2")

# Attente max en secondes (optionnel)
TIMEOUT=500
INTERVAL=30
elapsed=0

echo "⏳ Attente que les BlockDevices des workers soient détectés..."

while true; do
    pending=0

    for worker in "${WORKERS[@]}"; do
        # Vérifie si un blockdevice de ce worker existe
        worker_pending=$(kubectl get bd -n "$NAMESPACE" --no-headers | grep "$worker" | wc -l)

        if [ "$worker_pending" -eq 0 ]; then
            echo "🕑 Aucun blockdevice trouvé pour $worker."
            pending=1
        fi
    done

    if [ "$pending" -eq 0 ]; then
        echo "✅ Tous les BlockDevices des workers sont détectés."
        break
    fi

    if [ "$elapsed" -ge "$TIMEOUT" ]; then
        echo "❌ Timeout atteint après $TIMEOUT secondes. Certains BlockDevices des workers n'ont pas été trouvés."
        kubectl get bd -n "$NAMESPACE"
        exit 1
    fi

    sleep "$INTERVAL"
    elapsed=$((elapsed + INTERVAL))
done
