#!/bin/bash
#user is prompted for a remote connection string to Offline PacRIS system
read -p "Please Enter the connection string to Tonga PacRIS Offline (format: user@hostname) " CONN

#STAGE 2: DOWNLOAD OFFLINE BACKUPS AND TAR RECOVER DIRECTORIES TO PACRIS PRODUCTION ENVIRONMENT

###############START: SERVER COPY FUNCTION ####################
sudo scp "$CONN":/home/ubuntu/backups/* /home/ubuntu/backups/ 
if [ "$?" -eq "0" ]
then
    echo "SUCCESSFUL FILE TRANSFER"
else
    echo "FAILED FILE TRANSFER. Check your connection string again!"
    exit $?
fi
# ###############END: SERVER COPY FUNCTION####################

#set permissions on backups so this server instance can access all backup files within
sudo chmod -R 755 /home/ubuntu/backups

src_GEONODE_DATA_DB="/home/ubuntu/backups/src_geonode_data_DB.backup"
if [ -f "$src_GEONODE_DATA_DB" ]
then
echo "File $src_GEONODE_DATA_DB" exists
echo Restoring "$src_GEONODE_DATA_DB" database to geonode_data
sudo -u postgres -i pg_restore -h 192.168.137.12 -p 5432 -d src_geonode_data -v "/home/ubuntu/backups/src_geonode_data_DB.backup"
#exit $?
else
echo file "$src_GEONODE_DATA_DB" doesnt exist. Please make sure ALL files were transferred from offline pacRIS...
exit $?
fi

DIRECTORY="/home/ubuntu/backups/src_backups"
if [ ! -d "$DIRECTORY" ] 
then
echo "Directory $DIRECTORY does not exist"
echo "creating directory in $DIRECTORY"
sudo mkdir /home/ubuntu/backups/src_backups
else
echo "Directory $DIRECTORY exists"
echo "Proceeding with tar recoveries"
fi
echo RECOVER TAR DIRECTORIES TO $DIRECTORY DIRECTORY
#stop tomcat7 server
sudo service tomcat7 stop
sudo tar -xvpzf /home/ubuntu/backups/src_geonodeUploaded.tar.gz -C /home/ubuntu/backups/src_backups/

sudo tar -xvpzf /home/ubuntu/backups/src_geoserverDataBackup.tar.gz -C /home/ubuntu/backups/src_backups/	

echo SET PERMISSIONS ON TEMPORARY DIRECTORIES
sudo chmod -R 755 /home/ubuntu/backups/src_backups/usr
sudo chmod -R 755 /home/ubuntu/backups/src_backups/var
echo SET PERMISSIONS ON ENVIRONMENT DIRECTORIES
sudo chmod -R 755 /usr/share/geoserver/data
sudo chmod -R 755 /var/www/geonode/uploaded/

echo MOVING TAR RECOVERIES TO PRODUCTION ENVIRONMENT
#layers
mv /home/ubuntu/backups/src_backups/var/www/geonode/uploaded/layers/* /var/www/geonode/uploaded/layers/

#documents
mv /home/ubuntu/backups/src_backups/var/www/geonode/uploaded/documents/* /var/www/geonode/uploaded/documents/

#HANDINGLING GEOSERVER DATA DIRECTORY
echo REMOVING namespace.xml AND workspace.xml FROM /home/ubuntu/backups/src_backups/usr/share/geoserver/data/workspaces/geonode/ TEMPORARY DIRECTORY
rm /home/ubuntu/backups/src_backups/usr/share/geoserver/data/workspaces/geonode/namespace.xml
rm /home/ubuntu/backups/src_backups/usr/share/geoserver/data/workspaces/geonode/workspace.xml

echo MOVING WORKSPACES TO WORKSPACES PRODUCTION ENVIRONMENT
#move workspaces 
DIRECTORY="/home/ubuntu/backups/src_backups/datastore"
if [ ! -d "$DIRECTORY" ] 
then
echo "Directory $DIRECTORY does not exist"
echo "creating directory in $DIRECTORY"

sudo mkdir /home/ubuntu/backups/src_backups/datastore
else
echo "Directory $DIRECTORY exists"
echo "Recreate the directory"
sudo chmod -R 755 /home/ubuntu/backups/src_backups/datastore && rm -rf /home/ubuntu/backups/src_backups/datastore
sudo mkdir /home/ubuntu/backups/src_backups/datastore
sudo chmod 755 /home/ubuntu/backups/src_backups/datastore
fi
sudo mv /home/ubuntu/backups/src_backups/usr/share/geoserver/data/workspaces/geonode/datastore/* /home/ubuntu/backups/src_backups/datastore
sudo chmod -R 755 /home/ubuntu/backups/src_backups/datastore
rm /home/ubuntu/backups/src_backups/datastore/datastore.xml
sudo chmod -R 755 /home/ubuntu/backups/src_backups/usr/share/geoserver/data/workspaces/geonode/datastore
rm -rf /home/ubuntu/backups/src_backups/usr/share/geoserver/data/workspaces/geonode/datastore
# at this point we have a clean datastore and workspace ready to be moved to the production environment
sudo mv /home/ubuntu/backups/src_backups/datastore/* /usr/share/geoserver/data/workspaces/geonode/datastore
sudo mv /home/ubuntu/backups/src_backups/usr/share/geoserver/data/workspaces/geonode/* /usr/share/geoserver/data/workspaces/geonode

#move data layers
sudo mv /home/ubuntu/backups/src_backups/usr/share/geoserver/data/data/geonode/* /usr/share/geoserver/data/data/geonode/

#move styles
echo MOVING STYLES TO PRODUCTION STYLES ENVIRONMENT
sudo mv /home/ubuntu/backups/src_backups/usr/share/geoserver/data/styles/* /usr/share/geoserver/data/styles/

#set permissions to all migrated directories
sudo sudo chmod -R 755 /usr/share/geoserver/data
sudo sudo chmod -R 755 /var/www/geonode/uploaded

#start tomcat7 server
sudo service tomcat7 start
#DELETE TEMPORY DIRECTORIES within backups folder
sudo rm -r /home/ubuntu/backups/*

#HANDLE POSTGRES DATABASES
echo ..............CREATING POSTGRES DATABASES NOW...........
sudo service postgresql restart
#drop existing src_geonode in postgres
sudo -u postgres -i psql -c "drop database src_geonode;"
sudo -u postgres -i psql -c "drop database src_geonode_data;"
sudo -u postgres -i psql -c "create database src_geonode;"
sudo -u postgres -i psql -c "create database src_geonode_data;"

echo RESTORING POSTGRES DATABASES ...... 
src_GEONODEDB_DB="/home/ubuntu/backups/src_geonodeDB.backup"
if [ -f "$src_GEONODEDB_DB" ]
then
echo File "$src_GEONODEDB_DB" exist 
echo lets restore "$src_GEONODEDB_DB" database
sudo -u postgres -i pg_restore -h 192.168.137.12 -p 5432 -d src_geonode -v "/home/ubuntu/backups/src_geonodeDB.backup"
#exit $?
else
echo File "$src_GEONODEDB_DB" doesnt exist. Please make sure ALL files were transferred from offline pacRIS...
exit $?
fi

#STAGE 3: INTEGRATE src_geonode DATABASE WITH PACRIS PRODUCTION 	geonode DATABASE 	
#possible solutions are:
# 1. the use of an ETL (Extract Transform and Load) tool such as CloverETL or Talend Studio
# 2. Python programming

#INTERGRATE/UPDATE GEONODE ENVIRONMENT
geonode updatelayers
