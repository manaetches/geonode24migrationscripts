# geonode24migrationscripts
The purpose of this data migration procedure is to integrate geonode 2.4 databases and data directories between two server instances. The servers are linux based and the method of geonode installation is found at geonode.org (ppa installation). This procedure will migrate and integrate the following directories and databases.
	1. Geoserver data directory (Path: /usr/share/geoserver/)
	2. Geonode uploaded directory (Path: /etc/geonode/uploaded)
	3. Geonode database "geonode"
	4. Geonode database "geonode_data"

The migration procedure is carried out in a three stage process.
Stage 1 - The execution  of a backup script from geonode source.
Stage 2 - The execution of an integration script to download and integrate backup files from the source to the destination geonode system.
Stage 3 - An integration procedure to merge geonode databases (geonode, geonode_data) using an ETL tool such as CloverETL or Talend Studio

Steps:
1.	src_backup.sh script is implemented on the source geonode system to carry out backups of the directories and databases identified above.
2.	dst_integrate.sh is executed on the destination geonode system to prompt the user to input a connection string to a source geonode system. Upon a successful connection with root access to the source, an scp (secure copy) will download the backups (carried out in step 1), restore and allocate the data directories to the geonode destination directory environment and finally create the geonode postgres databases of the source. The creation of the databases of the source is required for ETL (Extract Transform Load) integration in step 3.
3.	To be completed - utilization of and ETL tool to integrate the databases of the geonode source to destination.