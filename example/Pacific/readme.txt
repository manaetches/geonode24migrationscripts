This example is specific to geonode systems residing in pacific island countries 
Tonga and Samoa.These systems are the geonode system source of this procedure.
 
Note:
./WS_backup.sh is to be executed within the geonode system residing in Samoa 
./TO_backup.sh is to be executed within the geonode system residing in Tonga

Important: Backup scripts must be executed first before carrying out the integration scripts ./WS_integrate.sh and /TO_integrate.sh

Scripts country.sh, WS_integrate.sh and TO_integrate.sh are to be implemented on the destination geonode system.

country.sh runs as the initialization script. i.e the root user is prompted to enter the connection string
to geonode systems residing within the countries. Upon a successful connection with root access,
the source integration script is implemented. For example, 

The root user will first run:
./country.sh

The root user is required to enter the name of the pacific island country to carry out a data integration.
Lets say the root user enters Tonga. Using a bash switch statement, the script references and executes ./TO_integrate.sh.
The subsequent integration process is implemented specifically for geonode system residing in Tonga.
 
 