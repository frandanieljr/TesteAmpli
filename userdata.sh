#!/bin/bash
set -e
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

function install_nginx {

	apt-get update && apt-get install -y nginx && service nginx start 
		
}
install_nginx

function mount_drive {
	
	sudo mkfs -t xfs /dev/xvdh && mkdir -p /data/logs && mount /dev/xvdh /data/logs

}
mount_drive

