#!/bin/bash
DIRECTORY="/home/ubuntu/backups"
if [ ! -d "$DIRECTORY" ] 
then
echo "Directory $DIRECTORY does not exist"
echo "creating directory witinin $DIRECTORY"
sudo mkdir /home/ubuntu/backups
else
echo "Directory $DIRECTORY exists"
echo "Proceeding with backups"
fi
echo ......................Creating Geonode Backups..................
echo .........STEP1: TAR geonodeGeoserver AND geonodeUploaded DIRECTORIES..........
sudo tar -czvf /home/ubuntu/backups/TO_geonodeUploadedDocuments.tar.gz  /var/www/geonode/uploaded/documents
sudo tar -czvf /home/ubuntu/backups/TO_geoserverDataBackup.tar.gz /usr/share/geoserver/data/
echo "Completed backups of directores"
echo .........STEP2: BACKUP GEONODE AND GEONODE_DATA POSTGRES DATABASES.........
sudo -u postgres -i pg_dump -c -Fc geonode > /home/ubuntu/backups/TO_geonodeDB.backup
sudo -u postgres -i pg_dump -c -Fc geonode_data > /home/ubuntu/backups/TO_geonode_data_DB.backup
echo "Completed backups of Postgres databases"
echo Backup Completed.

