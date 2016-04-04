#!/bin/bash
echo ......................Creating PCRAFI Geonode Backups..................
echo .........STEP1: TAR geonodeGeoserver AND geonodeUploaded DIRECTORIES..........
sudo tar -czvf /home/mana/backups/WS_geonodeUploaded.tar.gz  /var/www/geonode/uploaded
sudo tar -czvf /home/mana/backups/WS_geoserverDataBackup.tar.gz /usr/share/geoserver/data/
echo "Completed backups of directores"
echo .........STEP2: BACKUP GEONODE AND GEONODE_DATA POSTGRES DATABASES.........
sudo -u postgres -i pg_dump -c -Fc geonode > /home/mana/backups/WS_geonodeDB.backup
sudo -u postgres -i pg_dump -c -Fc geonode_data > /home/mana/backups/WS_geonode_data_DB.backup
echo "Completed backups of Postgres databases"
sudo chmod -R 777 /home/mana/backups
echo Backup Completed.
#sudo scp /home/mana/backups/* mana@192.168.137.4:/home/mana/backups