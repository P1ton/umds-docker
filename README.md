# umds-docker
Update Manager Download Service (UMDS) Docker Container for VMware vSphere 7.0

# Usage
Download the vCenter ISO  the right version. In folder umds located archive VMware-UMDS-7.*.*.*.tar.gz .<br> 
Copy archive to root folder umds-docker.<br>
Change UMDS_PACKAGE variable in Dockerfile, set you UMDS filename.<br>
Create folder for storage  and change path in docker-compose.yaml . If you need, change web server listen port.<br>
By default download run is every 24 hours, change or delete sleep in supervisor config file.<br>
If you delete sleep, need disable autorestart.

