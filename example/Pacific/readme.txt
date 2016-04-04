This example is specific to geonode systems residing within the pacific island countries, namely
Tonga and Samoa.This is relative to the geonode source of this procedure 
 
Note:
./WS_backup.sh is to be executed within the geonode system residing in Samoa 
./TO_backup.sh is to be executed within the geonode system residing in Tonga

Important: Backup scripts must be executed first before carrying out the integration scripts ./WS_integrate.sh and /TO_integrate.sh

As an example:

Step 1: 
 run ./TO_backups.sh within geonode server for Tonga. Four backups are made, namely TO_GeonodeUploadedDocuments.tar.gz, TO_geoserverDataBackups.tar.gz, TO_geonodeDB.backup and TO_geonode_data_DB.backup.

Scripts country.sh, WS_integrate.sh and TO_integrate.sh are to be executed on the destination geonode system.
country.sh runs as the initialization script. i.e the root user is prompted to enter the connection string
to geonode systems residing within the countries. Upon a successful connection with root access,
the source integration script is implemented. For example, 

Step 2:
 run ./country.sh

The root user is required to enter the name of the pacific island country to carry out a data integration.
Using a bash switch statement, the script references and executes ./TO_integrate.sh.
The subsequent integration process is implemented specifically for geonode system residing in Tonga. The backups performed in step 1 are downloaded, "tar" recovered and moved to their respective destination.

Step 3: Integrate Tonga's geonode database to geonode database of the destination server. This step may be carried out by an ETL tool or developing python scripts. - Pending for completion.
 
 
