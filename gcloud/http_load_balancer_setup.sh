#!/bin/bash

# Setup
# Create an instance template.
# Create a target pool.
# Create a managed instance group.
# Create a firewall rule named as allow-tcp-rule-966 to allow traffic (80/tcp).
# Create a health check.
# Create a backend service, and attach the managed instance group with named port (http:80).
# Create a URL map, and target the HTTP proxy to route requests to your URL map.
# Create a forwarding rule.

#Setup
gcloud config list
gcloud auth list

export PROJECT_ID=$(gcloud config get-value project

gcloud compute project-info describe --project $PROJECT_ID
# defaults propperties
# google-compute-default-region
# google-compute-default-zone

export REGION=us-east1
export ZONE=us-east1-b

gcloud config set compute/zone $ZONE
gcloud config set compute/region $REGION


#startup local file
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

# Create an instance template using local startup script
gcloud compute instance-templates create my-nginx-template --metadata-from-file startup-script=startup.sh


# Create a target pool.
gcloud compute target-pools create my-nginx-pool


# Create a managed instance group. of 2 nginx web servers
gcloud compute instance-groups managed create my-nginx-group \
	--base-instance-name nginx \
	--size 2 \
	--template my-nginx-template \
	--target-pool my-nginx-pool

gcloud compute instances list


# Create a firewall rule named as allow-tcp-rule-http to allow traffic (80/tcp).
gcloud compute firewall-rules create allow-tcp-rule-http --allow tcp:80

# create a forwarding rule
gcloud compute forwarding-rules create my-nginx-lb \
	--region $REGION \
	--ports=80 \
	--target-pool my-nginx-pool

gcloud compute forwarding-rules list
