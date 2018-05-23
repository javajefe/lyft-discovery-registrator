#!/bin/bash

# AWS instance metadata service
function aws-meta() {
	curl -sf http://169.254.169.254/latest/meta-data/$1
}

function init-aws() {
	export instance_id=$(aws-meta instance-id)
	export ip=$(aws-meta local-ipv4)
	export az=$(aws-meta placement/availability-zone)
	if [ ${#instance_id} -eq 0 -o ${#ip} -eq 0 -o ${#az} -eq 0 ]
	then
		export instance_id=""
		export ip=""
		export az=""
		export region=""
	else
		export region=${az:0:-1}
	fi
}

function init-docker() {
	export ip=$(dig +short $1 | head -n 1)
	export az=zzz
	export region=rrr
	export instance_id=iii
}

while true
do
	if [ $ENVIRONMENT == "AWS" ] 
	then
		init-aws
	else
		init-docker $PROXY_NETWORK_ALIAS
	fi
	
	if [ ${#ip} -ne 0 ]
	then
		envsubst < template > service.post
		echo Registering $SERVICE_NAME with address $ip:$PROXY_HOST_PORT:
		cat service.post

		curl -vs -X POST -d @service.post $DISCOVERY_URL/v1/registration/$SERVICE_NAME
	else
		echo Can not find IP. Check the proxy container is running... 
	fi
	
	sleep $REFRESH_INTERVAL
done