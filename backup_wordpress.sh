#!/bin/bash

# Définition des variables
BACKUP_DIR="/backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="wordpress_backup_${TIMESTAMP}.tar.gz"
CONTAINER_DB="mysql"
CONTAINER_WP="wordpress"
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress"  # À remplacer par le vrai mot de passe

# Informations pour la machine locale
LOCAL_USER="christ"
LOCAL_HOST="192.168.1.100"  # Remplace par l'IP de ta machine locale
LOCAL_DEST="/home/christ/wordpress_backups"

# Création du dossier de sauvegarde s'il n'existe pas
sudo mkdir -p "$BACKUP_DIR"

echo "Sauvegarde des fichiers WordPress..."
docker cp "$CONTAINER_WP:/var/www/html/wp-content" "$BACKUP_DIR/wp-content"

echo "Sauvegarde de la base de données MySQL..."
docker exec "$CONTAINER_DB" mysqldump --no-tablespaces -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/db_backup.sql"

echo "Compression des fichiers..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$BACKUP_DIR" wp-content db_backup.sql

echo "Transfert de la sauvegarde vers la machine locale..."
scp -r "$BACKUP_DIR/wp-content" "$BACKUP_DIR/$BACKUP_NAME" "$LOCAL_USER@$LOCAL_HOST:$LOCAL_DEST"

if [ $? -eq 0 ]; then
    echo "Transfert réussi vers $LOCAL_USER@$LOCAL_HOST:$LOCAL_DEST"
else
    echo "Erreur lors du transfert."
fi

echo "Sauvegarde et transfert terminés !"

echo "Sauvegarde terminée : $BACKUP_DIR/$BACKUP_NAME"




#  Utilisation
# Donne les bons noms aux containers : Mets à jour CONTAINER_DB et CONTAINER_WP avec ceux de ton docker-compose.yml.
# 
# Ajoute le bon mot de passe MySQL : Remplace your_db_password par le mot de passe MySQL réel.
# 
# Rends le script exécutable :
# 
# bash
# 
# chmod +x backup_wordpress.sh
# Exécute le script :
# 
# bash
#
# ./backup_wordpress.sh
# 🔄 Automatisation
# Ajoute une tâche cron pour une sauvegarde quotidienne :
# 
# bash
#
# crontab -e
# Ajoute cette ligne (sauvegarde à 3h du matin chaque jour) :
# 
# bash
#
# 0 3 * * * /path/to/backup_wordpress.sh >> /var/log/wordpress_backup.log 2>&1