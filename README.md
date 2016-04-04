# geonode_2.4_migration_scripts
The purpose of this data migration procedure is to integrate geonode 2.4 databases and data directories between two server instances of similar structures. The servers are linux based and the method of geonode installation is found at geonode.org (ppa installation). This procedure will migrate and integrate the following directories and databases:

	1. Geoserver data directory (Path: /usr/share/geoserver/) 
	2. Geonode uploaded directory (Path: /etc/geonode/uploaded)
	3. Geonode database "geonode"
	4. Geonode database "geonode_data"

The migration procedure is carried out in three stages:

	Stage 1 - The execution  of a backup script from geonode source. 
	This script is labelled src_backup and will reside on the geonode system that is the source of this procedure
	Stage 2 - The execution of an integration script (dst_integrate.sh) to download and "tar recover"backup files from the source to the destination geonode system.
	Stage 3 - An integration procedure to merge geonode databases (geonode, geonode_data) using an ETL tool such as CloverETL or Talend Studio. 
	Or another alternative is develop a python script to integrate the databases.
	
NOTE: What is pending for completion is the development of Stage 3.

