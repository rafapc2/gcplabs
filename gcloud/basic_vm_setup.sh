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

export PROJECT_ID=$(gcloud config get-value project)

gcloud compute project-info describe --project $PROJECT_ID
# defaults propperties
# google-compute-default-region
# google-compute-default-zone

export REGION=us-east1
export ZONE=us-east1-b

gcloud config set compute/region "zone=$ZONE"
gcloud config set compute/region "region=$REGION"