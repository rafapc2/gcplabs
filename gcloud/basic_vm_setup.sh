#!/bin/bash

# Setup
# Create vm and have fun.

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

gcloud compute instances create my-vm1 --machine-type e2-medium --zone=$ZONE
gcloud compute ssh my-vm1 --zone=$ZONE

