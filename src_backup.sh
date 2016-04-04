#!/bin/bash
#STAGE 1
#Note: the following script will backup geoserver data directory, uploaded directory, the databases "geonode"
# and "geonode_data" of the geonode source. All backups are prefixed with src_
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
echo ......................Creating PCRAFI Geonode Backups..................
echo .........STEP1: TAR geonodeGeoserver AND geonodeUploaded DIRECTORIES..........
sudo tar -czvf /home/ubuntu/backups/src_geonodeUploadedDocuments.tar.gz  /var/www/geonode/uploaded/documents
sudo tar -czvf /home/ubuntu/backups/src_geoserverDataBackup.tar.gz /usr/share/geoserver/data/
echo "Completed backups of directores"
echo .........STEP2: BACKUP GEONODE AND GEONODE_DATA POSTGRES DATABASES.........
sudo -u postgres -i pg_dump -c -Fc geonode > /home/ubuntu/backups/src_geonodeDB.backup
sudo -u postgres -i pg_dump -c -Fc geonode_data > /home/ubuntu/backups/src_geonode_data_DB.backup
echo "Completed backups of Postgres databases"
sudo chmod -R 775 /home/ubuntu/backups
echo Backup Completed.

